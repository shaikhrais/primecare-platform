// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
class ErrorMapper {
  static String mapApiErrorToUiMessage(dynamic error) {
    if (error == null) return "An unknown system error occurred.";

    final errorString = error.toString().toLowerCase();

    if (errorString.contains("timeout") || errorString.contains("socket")) {
      return "Unable to reach the PrimeCare server. Please check your connection.";
    }
    if (errorString.contains("401") || errorString.contains("unauthorized")) {
      return "Your session has expired. Please log in again.";
    }
    if (errorString.contains("404")) {
      return "The requested record could not be found.";
    }

    return "Something went wrong while processing your request. Please try again.";
  }
}
