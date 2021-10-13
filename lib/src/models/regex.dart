const String urlRegex = r'^(?:(?:https?):\/\/)[\w/\-?=%.]+\.[\w/\-?=%.]+$';

const String hexRegexWithBoth = r'^[#]?[a-fA-F0-9]{6}$';
const String hexRegexWithHashtag = r'^#[a-fA-F0-9]{6}$';
const String hexRegexWithoutHashtag = r'^[a-fA-F0-9]{6}$';

const String alphaNumericRegex = r'^[a-zA-Z0-9]+$';

const String numericRegex = r'^[0-9]+$';
const String emailRegex =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
