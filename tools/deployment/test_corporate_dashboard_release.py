"""Contract fixtures: no services, production secrets or state."""
import copy
import unittest
from unittest.mock import patch
from . import dashboard_release_intent as release_intent
from . import dashboard_publish_scope as publish_scope
from . import corporate_dashboard_release as scope


class CohortTests(unittest.TestCase):
    def setUp(self):
        def item(i):
            return {"project":scope.PROJECT, "appCode":"co", "code":f"code_{i}", "route":f"/exact/{i}"}
        self.rows = [item(i) for i in range(12)]
        self.registered = {("co", x["code"], x["route"]):scope.PROJECT for x in self.rows}
        self.prior = {"version":1, "retained":[], "cohorts":[]}
        self.first = {**self.prior, "cohorts":[{"id":"corporate-01", "dashboards":self.rows[:10]}]}
        self.second = {**self.first, "cohorts":[*self.first["cohorts"], {"id":"corporate-02", "dashboards":[self.rows[10]]}]}
        self.first_codes=[x["code"] for x in self.rows[:10]]
        self.second_codes=[self.rows[10]["code"]]
        self.next_nine={"head":scope.NEXT_NINE,"workflow_blob":scope.NEXT_NINE_WORKFLOW,"projects":{
            p:{"head":scope.NEXT_NINE,"verify_run":v,"publish_run":v+1,"asset_digest":"a"*64}
            for p,v in scope.VERIFY_ONLY.items()
        }}

    def test_exact_ten_then_one(self):
        scope.validate_delta(self.prior,self.first,"corporate-01",self.registered,self.first_codes)
        scope.validate_delta(self.first,self.second,"corporate-02",self.registered,self.second_codes)

    def test_deny_eleven_in_one_or_two_cohorts(self):
        with self.assertRaises(ValueError):scope.validate_delta(self.prior,self.second,"corporate-01",self.registered,self.first_codes)
        b=copy.deepcopy(self.first); b["cohorts"][0]["dashboards"].append(self.rows[10])
        with self.assertRaises(ValueError):scope.validate_delta(self.prior,b,"corporate-01",self.registered,self.first_codes)

    def test_deny_existing_cohort_rewrite(self):
        b=copy.deepcopy(self.second);b["cohorts"][0]["dashboards"].reverse()
        with self.assertRaises(ValueError):scope.validate_delta(self.first,b,"corporate-02",self.registered,self.second_codes)

    def test_deny_other_portal_or_route(self):
        for field,val in [("project","primecare-support"),("appCode","su"),("route","/alias"),("code","not_registered")]:
            b=copy.deepcopy(self.first);b["cohorts"][0]["dashboards"][0][field]=val
            with self.assertRaises(ValueError):scope.validate_delta(self.prior,b,"corporate-01",self.registered,self.first_codes)

    def test_deny_duplicate(self):
        b=copy.deepcopy(self.first); b["cohorts"][0]["dashboards"][0]=b["cohorts"][0]["dashboards"][1]
        with self.assertRaises(ValueError):scope.validate_delta(self.prior,b,"corporate-01",self.registered,self.first_codes)

    def test_deny_verify_only_or_missing_live_receipt(self):
        scope.validate_next_nine(self.next_nine)
        b=copy.deepcopy(self.next_nine)
        b["projects"]["primecare-marketing"]["publish_run"]=scope.VERIFY_ONLY["primecare-marketing"]
        with self.assertRaises(ValueError):scope.validate_next_nine(b)
        del b["projects"]["primecare-franchise"]
        with self.assertRaises(ValueError):scope.validate_next_nine(b)

    def test_external_writer_scope_skips_exact_infrastructure_only(self):
        self.assertFalse(publish_scope.allow_legacy("push", release_intent.CORPORATE_INFRA))
        self.assertTrue(publish_scope.allow_legacy("workflow_dispatch", set()))
        self.assertTrue(publish_scope.allow_legacy("push", {"websites/typescript/src/external-calls.ts"}))
        with self.assertRaises(ValueError):
            publish_scope.allow_legacy("push", release_intent.CORPORATE_INFRA | {"cloudflare/workers/src/x.ts"})

    def test_automatic_publish_accepts_no_bypass_for_corporate_marker(self):
        paths={scope.INTENT,scope.MANIFEST}
        marker='{"intent":"corporate-dashboard-cohort","previous_live":"'+scope.FIRST_LIVE+'"}'
        with patch("pathlib.Path.read_text",return_value=marker),patch.object(scope,"preflight") as reviewed:
            with self.assertRaises(ValueError):
                publish_scope.allow_legacy("push",paths,"before")
            self.assertFalse(publish_scope.allow_legacy("push",paths,"before","after"))
            reviewed.assert_called_once_with("before","after",scope.PROJECT,scope.FIRST_LIVE)
            reviewed.side_effect=ValueError("unverified")
            with self.assertRaises(ValueError):
                publish_scope.allow_legacy("push",paths,"before","after")
