import {SuperSearch} from './fussy'
import './styles'
# let chamquery = ''
# let engquery = ''

# tag SearchBar
# 	css input
# 		bg:gray3
# 		d:block
# 		mb:2px
# 		p:2
# 		rd:2
# 		mx:auto
# 		w:100%
# 	def render
# 		<self>
# 			# <input placeholder="search cham" bind=chamquery>
# 			<input placeholder="English to Cham Dictionary" bind=engquery>
# tag Results
# 	css div
# 		bxs:lg
# 		p:4
# 		rd:4
# 		bg:white
# 		flex: 0 1 24%;
# 		mb:1em
# 		min-width: 200px
# 		h3
# 			c:blue7
# 		.cham
# 			c:gray7
# 			fw:300
# 		.use
# 			float:right
# 			c:gray3
		
# 	css &
# 		d:flex
# 		jc:space-around
# 		flw:wrap
# 	def render
# 		<self>
# 			for word in data
# 				cham = word[0]
# 				note = word[1]
# 				check = word[2]
# 				eng = word[4][0][0]
# 				use = word[4][0][2]
# 				if fussy(chamquery.toLowerCase!, cham.toLowerCase!) and fussy(engquery.toLowerCase!, eng.toLowerCase!)
# 					<div> 
# 						<h3> eng.replace! /(^\w{1})|(\s+\w{1})/g, do(letter) letter.toUpperCase!
# 						<span.cham> "{cham}" 
# 						<span.use> "{use}"

# tag SearchTwo
# 	### TODOS
# 	[] import './data.json'
# 	[] store in variable
# 	[] filter by word[4][0][0] english word
# 	[] or by cham word[0] cham word
#  	###
# 	# prop office = ['Kelly', 'Creed', 'Stanley', 'Oscar', 'Michael', 'Jim', 'Darryl', 'Phyllis', 'Pam', 'Dwight', 'Angela', 'Andy', 'William', 'Ryan', 'Toby', 'Bob']
# 	prop query = ''
# 	prop results = []
	
# 	# Get array of English words in Dictionary Array
# 	# find query match in english array
# 	# return indexes
# 	# render dictionary object index

# 	# get array of english words from dictionary 'data.json'
# 	def getEngArray
# 		dictionary = await window.fetch('data.json')
# 		data = await dictionary.json!
# 		needle = query.toLowerCase().substring(0,3)
# 		engArray = data.map!
# 			do(word)
# 				word[4][0][0]
# 		return engArray

# 	# get array of cham words from dictionary 'data.json'
# 	def getChamArray
# 		dictionary = await window.fetch('data.json')
# 		data = await dictionary.json!
# 		needle = query.toLowerCase().substring(0,3)
# 		chamArray = data.map!
# 			do(word)
# 				word[0]
# 		return chamArray


# 	def findIndex haystackArray, needleString
# 		h = haystackArray
# 		n = needleString
# 		return h.findIndex(do(x) x is needleString)









# 	def checkHaystack haystack, needle
# 		# create a regex pattern to find each needle's letter in haystack with regex
# 		pattern = needle.split("").map(do(x)
# 			return "(?=.*{x})"
# 			).join("")
# 		# Create a regex with pattern, global, Cap insensitive
# 		regex = new RegExp("{pattern}", "gi")
# 		# Return the haystack matching the regex
# 		return haystack.match(regex)




# 	def getIndexOfMatch
# 		needle = query.toLowerCase().substring(0,3)
# 		# get array of english words in dictionary
# 		console.log "Eng Array: {getEngArray!}"
# 		results = await getEngArray! do(x)
# 			xSub = x.substring(0,3)
# 			x.includes(needle) or checkHaystack(xSub, needle)
# 		# console.log findIndex(results, needle)
# 		console.log "Results: {results}"

# 		if results.length > 0
# 			return results
# 		else
# 			console.log "no results"



# 	def render
# 		<self>
# 			<input[bg:gray3 p:4 mx:auto d:block mb:3] placeholder="Filter Simple Array" @keyup.getIndexOfMatch bind=query>
# 			# <input[bg:gray3 p:4 mx:auto d:block mb:3] placeholder="Filter Dictionary Array" @keyup.getEngArray bind=query>
# 			<ResultsTwo bind:results=results bind:query=query>

# tag ResultsTwo
# 	def render
# 		<self>
# 			<section> 
# 				<h1> "Results"
# 				<p> "query: {query}"
# 				<p> "results: {results}"
# tag App
# 	css &
# 		bg:gray1
# 		d:block
# 		p:4
# 	prop engquery = ""
# 	prop chamquery = ""
# 	def getStuff
# 		dictionary = await window.fetch('data.json')
# 		data = await dictionary.json!
# 		console.log data
# 		return data
# 	# def mount
# 	# 	getStuff!
# 	def render
# 		<self[ff:sans fw:bold]>
# 			<SearchTwo>
# 			# <NewSearch>
# 			# <SearchBar>
# 			# <Results bind:data=data>

### ATTEMPT TWO
###
tag app-root
	# PROPS
	prop dictionary
	prop dict
	prop query = ''
	prop randomNum = 1
	# STYLES
	css &
		d:block
	css header
		p:4
		bg:gray9
	css input
		w:100%
		p:2
		py:3
		rd:2
	css %results
		d:flex
		fld:column
		flw:wrap
		bg:gray1
	css %card
		bxs:sm
		my:1
		p:2
		rd:2
		bg:white
		d:flex
		ac:center
	css %left
		flg:1
		# ai:center
	css %right
		flg:0
		d:flex
		ai:center

	css %english
		c:red6/40
		d:block
		fs:1,2em
	css %cham
		c:gray8
	css %use
		c:gray3
		float:right
	css section 
		p:4
	def loadDict
	# METHODS
	def mount
		dictionary = await window.fetch('./data02.json')
		dict = await dictionary.json!
		random = Math.floor(Math.random() * dict.length);
	# VIEW
	def render
		loadDict!
		<self>
			<header>
				<input placeholder="English to Cham Dictionary" bind=query>
			<section%results>
				for item in dict
						if SuperSearch(query,item[0])
							<div%card> 
								<div%left>
									<span%english> 	"{item[0]} "
									<span%cham> 	"{item[1]} "
								<div%right>
									<span%use> 	"{item[2]}"





### data reformatter
tag App
	def mount
		dictionary = await window.fetch('./data.json')
		dict = await dictionary.json!
	def render
		<self>
			<pre> 
				for one in dict
					<span>
					let cham = one[0]
					let engArray = one[4]
					for eng in engArray
						let word = eng[0]
						let info = eng[1]
						let use = eng[2]
						<div> 
							<span> "[\"{word}\", "
							<span[c:red]> "\"{cham}\", "
							<span> "\"{use}\"],"
						<div[c:red]> 
###

# imba.mount <App>
imba.mount <app-root>