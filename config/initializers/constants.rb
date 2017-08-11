# VALID_NAME_REGEX = /[0-9a-zA-Z\._\-]+/
VALID_NAME_REGEXP = /[a-z]+[a-z0-9]+([\._\-][0-9a-z]+)*/
VALID_ID_ROUTES_REGEXP = Regexp.new(VALID_NAME_REGEXP.source + '|[0-9]+')
