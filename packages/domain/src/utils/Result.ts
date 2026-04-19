/**
 * A standard wrapper for operation results in the PrimeCare domain layer.
 * Ensures consistent error handling and resilience patterns across all services.
 */
export class Result<T> {
    private constructor(
        private readonly _isSuccess: boolean,
        private readonly _data?: T,
        private readonly _error?: string
    ) { }

    public static ok<T>(data: T): Result<T> {
        return new Result<T>(true, data);
    }

    public static fail<T>(error: string): Result<T> {
        return new Result<T>(false, undefined, error);
    }

    /**
     * Executes an async operation and wraps it in a Result block.
     */
    public static async guard<T>(fn: () => Promise<T>): Promise<Result<T>> {
        try {
            const data = await fn();
            return Result.ok<T>(data);
        } catch (error: any) {
            return Result.fail<T>(error.message || 'An unexpected error occurred');
        }
    }

    public get isSuccess(): boolean { return this._isSuccess; }
    public get isFailure(): boolean { return !this._isSuccess; }
    public get data(): T {
        if (this.isFailure) throw new Error('Cannot access data of a failed Result');
        return this._data!;
    }
    public get error(): string {
        if (this._isSuccess) throw new Error('Cannot access error of a successful Result');
        return this._error!;
    }

    /**
     * Declarative handler for operation outcomes.
     */
    public fold<U>(onSuccess: (data: T) => U, onFailure: (error: string) => U): U {
        if (this._isSuccess) {
            return onSuccess(this.data);
        } else {
            return onFailure(this.error);
        }
    }
}
