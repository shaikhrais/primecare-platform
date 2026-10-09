/** Shared request lifecycle. Instances must never retain per-request identity or state. */
export abstract class BaseWorker<Environment> {
  async fetch(request: Request, env: Environment): Promise<Response> {
    try {
      const early = await this.preflight(request, env);
      if (early) return early;
      return await this.handle(request, env);
    } catch (error) {
      return this.onError(error, request, env);
    }
  }

  protected preflight(_request: Request, _env: Environment): Response | null | Promise<Response | null> {
    return null;
  }
  protected abstract handle(request: Request, env: Environment): Promise<Response>;
  protected onError(error: unknown, _request: Request, _env: Environment): Response | Promise<Response> {
    // Gateway binding failures retain the existing runtime failure semantics.
    throw error;
  }
}

/** Plain Worker export retains its callable fetch even when destructured by a host. */
export function workerHandler<Environment>(worker: BaseWorker<Environment>) {
  return {
    fetch: (request: Request, env: Environment): Promise<Response> => worker.fetch(request, env),
  };
}
