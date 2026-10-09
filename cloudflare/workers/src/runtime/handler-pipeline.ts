/** Request-local context; never store tokens, actors or tenants on a shared class. */
export interface WorkerContext<E> {
  readonly request: Request;
  readonly env: E;
  readonly path: string;
  readonly headers: HeadersInit;
}

export interface HandlerStage<E> {
  readonly name: string;
  readonly handle: (context: WorkerContext<E>) => Response | null | Promise<Response | null>;
}

/** Ordered composition of existing handlers. The first response owns the request. */
export class HandlerPipeline<E> {
  private readonly stages: readonly HandlerStage<E>[];

  constructor(stages: readonly HandlerStage<E>[]) {
    this.stages = Object.freeze(stages.map(stage => Object.freeze({...stage})));
  }

  async run(context: WorkerContext<E>): Promise<Response | null> {
    for (const stage of this.stages) {
      const response = await stage.handle(context);
      if (response !== null) return response;
    }
    return null;
  }
}
