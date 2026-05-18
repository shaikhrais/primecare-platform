export function successResponse<T>(data: T, message: string = 'Success') {
  return {
    status: 'success',
    message,
    data,
    timestamp: new Date().toISOString()
  }
}

export function errorResponse(message: string, code: string = 'ERROR', status: number = 400) {
  return {
    status: 'error',
    error: {
      code,
      message
    },
    timestamp: new Date().toISOString()
  }
}
