const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
  "Access-Control-Max-Age": "86400",
};

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;

    // Handle OPTIONS Preflight
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders,
      });
    }

    try {
      if (request.method === "GET") {
        if (path === "/api/data") {
          return await handleGetData(env);
        }
        if (path === "/" || path === "/index.html") {
          return new Response(
            `<!DOCTYPE html>
            <html>
            <head>
              <title>PrimeCare Quality Governance Edge API</title>
              <style>
                body {
                  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                  background-color: #0f172a;
                  color: #f8fafc;
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                  justify-content: center;
                  height: 100vh;
                  margin: 0;
                }
                .container {
                  text-align: center;
                  padding: 40px;
                  background-color: rgba(30, 41, 59, 0.5);
                  border: 1px solid rgba(255, 255, 255, 0.08);
                  border-radius: 16px;
                  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
                }
                h1 {
                  font-size: 28px;
                  background: linear-gradient(to right, #3b82f6, #ec4899);
                  -webkit-background-clip: text;
                  -webkit-text-fill-color: transparent;
                }
                p {
                  color: #94a3b8;
                  font-size: 14px;
                }
                .badge {
                  background-color: rgba(16, 185, 129, 0.1);
                  border: 1px solid #10b981;
                  color: #10b981;
                  padding: 6px 12px;
                  border-radius: 9999px;
                  font-size: 12px;
                  font-weight: bold;
                }
              </style>
            </head>
            <body>
              <div class="container">
                <h1>PrimeCare Quality Governance Database Edge API</h1>
                <p>Status: <span class="badge">ACTIVE (ONLINE)</span></p>
                <p style="margin-top: 20px;">Edge D1 serverless database connection is operational.</p>
              </div>
            </body>
            </html>`,
            {
              headers: {
                "Content-Type": "text/html",
              },
            }
          );
        }
      }

      if (request.method === "POST") {
        if (path === "/api/remarks") {
          return await handlePostRemarks(request, env);
        }
        if (path === "/api/like") {
          return await handlePostLike(request, env);
        }
      }

      // Default 404
      return new Response(JSON.stringify({ error: `Not Found: ${path}` }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });

    } catch (err) {
      console.error("Unhandled edge exception:", err);
      return new Response(
        JSON.stringify({
          status: "error",
          message: "Internal Server Error",
          error: err.message,
        }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }
  },
};

async function handleGetData(env) {
  if (!env.primecare_governance_db) {
    throw new Error("D1 database binding 'primecare_governance_db' is missing!");
  }

  // Fetch all tables in parallel to minimize latency
  const [orgsResult, appsResult, rolesResult, screensResult] = await Promise.all([
    env.primecare_governance_db.prepare("SELECT id, org_code, org_name FROM orgs").all(),
    env.primecare_governance_db.prepare("SELECT id, org_id, app_code, app_name FROM apps").all(),
    env.primecare_governance_db.prepare("SELECT id, org_id, role_code, role_name, test_email, test_login_verified, test_login_last_status, test_login_last_run_at, auth_screenshot_path, auth_video_path, primary_app_code FROM roles").all(),
    env.primecare_governance_db.prepare("SELECT id, app_id, role_id, screen_code, screen_name, route_path, cypress_ready, cypress_ready_status, screenshot_path, video_recording_path, when_tested, is_valid, complexity_score, estimated_loc, maintainability_score, user_remarks, user_remark_status, required_components_json, actual_components_json, actual_file_path, allowed_roles_text, supports_mobile, supports_tablet FROM screens").all(),
  ]);

  return new Response(
    JSON.stringify({
      orgs: orgsResult.results || [],
      apps: appsResult.results || [],
      roles: rolesResult.results || [],
      screens: screensResult.results || [],
      live: true,
    }),
    {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    }
  );
}

async function handlePostRemarks(request, env) {
  if (!env.primecare_governance_db) {
    throw new Error("D1 database binding 'primecare_governance_db' is missing!");
  }

  const { screen_code, user_remarks, user_remark_status } = await request.json();

  if (!screen_code) {
    return new Response(JSON.stringify({ error: "Missing screen_code parameter" }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }

  // Check if screen exists (normalized query)
  const screen = await env.primecare_governance_db.prepare(
    "SELECT id FROM screens WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))"
  ).bind(screen_code).first();

  if (!screen) {
    return new Response(JSON.stringify({ error: `Screen '${screen_code}' not found` }), {
      status: 404,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }

  // Update remarks
  await env.primecare_governance_db.prepare(
    "UPDATE screens SET user_remarks = ?, user_remark_status = ? WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))"
  ).bind(user_remarks, user_remark_status, screen_code).run();

  return new Response(
    JSON.stringify({
      status: "success",
      message: `Successfully updated remarks for screen: ${screen_code}`,
    }),
    {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    }
  );
}

async function handlePostLike(request, env) {
  if (!env.primecare_governance_db) {
    throw new Error("D1 database binding 'primecare_governance_db' is missing!");
  }

  const { screen_code } = await request.json();

  if (!screen_code) {
    return new Response(JSON.stringify({ error: "Missing screen_code parameter" }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }

  // Check if screen exists (normalized query)
  const screen = await env.primecare_governance_db.prepare(
    "SELECT id FROM screens WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))"
  ).bind(screen_code).first();

  if (!screen) {
    return new Response(JSON.stringify({ error: `Screen '${screen_code}' not found` }), {
      status: 404,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }

  // Update like parameters (is_valid = 1, approved remarks)
  await env.primecare_governance_db.prepare(
    "UPDATE screens SET is_valid = 1, user_remarks = 'Manually Liked & Approved.', user_remark_status = 'none' WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))"
  ).bind(screen_code).run();

  return new Response(
    JSON.stringify({
      status: "success",
      message: `Successfully liked and manually approved screen: ${screen_code}`,
    }),
    {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    }
  );
}
