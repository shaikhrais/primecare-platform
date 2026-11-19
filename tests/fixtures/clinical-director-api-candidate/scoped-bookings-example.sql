-- Fixture-only example, not an approved API response or a live query.
-- $1 and $2 must come from authenticated server context, never request input.
-- $3 and $4 are approved, server-computed UTC bounds; API validation is separate.
WITH scope AS (
    SELECT tenant_id, branch_id
    FROM clinical_director_effective_branch_scope
    WHERE tenant_id = $1 AND director_user_id = $2
), measured AS (
    SELECT count(*)::integer AS booking_count
    FROM bookings b JOIN scope s
      ON s.tenant_id = b.tenant_id AND s.branch_id = b.branch_id
    WHERE b.start_at >= $3::timestamptz AND b.start_at < $4::timestamptz
)
SELECT booking_count FROM measured WHERE EXISTS (SELECT 1 FROM scope);
