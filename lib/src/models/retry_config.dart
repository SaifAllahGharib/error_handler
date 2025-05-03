class RetryConfig {
  final int maxRetries;
  final Duration retryInterval;
  final bool Function(Exception exception)? shouldRetry;

  const RetryConfig({
    this.maxRetries = 1,
    this.retryInterval = Duration.zero,
    this.shouldRetry,
  });

  bool canRetry(Exception exception, int attempt) {
    return attempt < maxRetries &&
        (shouldRetry == null || shouldRetry!(exception));
  }
}
