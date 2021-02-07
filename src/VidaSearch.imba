
def checkInclude n, h
	return h.toLowerCase!.includes(n)

def checkPattern n, h
	let pattern = n.split("").map(do(x)
		return "(?=.*{x})"
		).join("")

	let regex = new RegExp(pattern, "gi")
	return h.match(regex)

def sub n
	let substring = n.substring(0, 4).toLowerCase()
	return substring

def matchLength needle, haystack
	needle = needle.toLowerCase!
	haystack = haystack.toLowerCase!
	let haystackLength = haystack.length
	let needleLength = needle.length
	if needleLength > haystackLength
		return false
	if needleLength is haystackLength
		return needle is haystack
	let needleLetter = 0
	while needleLetter < needleLength
		let haystackLetter = 0
		let match = false
		let needleLetterCode = needle.charCodeAt(needleLetter++)
		while haystackLetter < haystackLength
			if haystack.charCodeAt(haystackLetter++) is needleLetterCode
				break match = true
		continue if match
		return false
	return true

def tooLong n, h
	if h.length > n.length
		return false
def trim string
	return string.replace(/\s/g, '')

export def VidaSearch needle, haystack
	if checkInclude(sub(trim(needle)), trim(haystack)) and matchLength(needle, haystack)
		return true
	elif checkPattern(sub(needle), sub(haystack))
		return true
	else
		return false
	# return true if checkPattern(sub(needle),haystack)