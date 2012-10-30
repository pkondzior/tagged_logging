tagged_logging
==============

Rails 3.2 TaggedLogging backported to Rails 3.0

Wraps any standard Logger object to provide tagging capabilities.

    logger = TaggedLogging.new(Logger.new(STDOUT))
    logger.tagged('BCX') { logger.info 'Stuff' }                            # Logs "[BCX] Stuff"
    logger.tagged('BCX', "Jason") { logger.info 'Stuff' }                   # Logs "[BCX] [Jason] Stuff"
    logger.tagged('BCX') { logger.tagged('Jason') { logger.info 'Stuff' } } # Logs "[BCX] [Jason] Stuff"

This is used by the default Rails.logger as configured by Railties to make
it easy to stamp log lines with subdomains, request ids, and anything else
to aid debugging of multi-user production applications.