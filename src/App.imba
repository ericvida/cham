import {fussy} from './fussy'
import './styles'
let chamquery = ''
let engquery = ''

tag SearchBar
	css input
		bg:gray3
		d:block
		mb:2px
		p:2
		rd:2
		mx:auto
		w:100%
	def render
		<self>
			# <input placeholder="search cham" bind=chamquery>
			<input placeholder="English to Cham Dictionary" bind=engquery>
tag Results
	css div
		bxs:lg
		p:4
		rd:4
		bg:white
		flex: 0 1 24%;
		mb:1em
		min-width: 200px
		h3
			c:blue7
		.cham
			c:gray7
			fw:300
		.use
			float:right
			c:gray3
		
	css &
		d:flex
		jc:space-around
		flw:wrap
	def render
		<self>
			for word in data
				cham = word[0]
				note = word[1]
				check = word[2]
				eng = word[4][0][0]
				use = word[4][0][2]
				if fussy(chamquery.toLowerCase!, cham.toLowerCase!) and fussy(engquery.toLowerCase!, eng.toLowerCase!)
					<div> 
						<h3> eng.replace! /(^\w{1})|(\s+\w{1})/g, do(letter) letter.toUpperCase!
						<span.cham> "{cham}" 
						<span.use> "{use}"
# appendNodes


tag SearchTwo
	prop office = ['Kelly', 'Creed', 'Stanley', 'Oscar', 'Michael', 'Jim', 'Darryl', 'Phyllis', 'Pam', 'Dwight', 'Angela', 'Andy', 'William', 'Ryan', 'Toby', 'Bob']
	prop query
	prop filteredArr = []
	def filterFunction
		filteredArr = office.filter(do(x)
			return x.toLowerCase!.includes(query.toLowerCase!)
			)
		if filteredArr.length > 0
			return filteredArr
		else
			console.log "no results"
	def checkName name, str
		pattern = str.split("").map(do(x)
			return "(?=.*{x})"
			).join("")
		regex = new RegExp("{pattern}", "g")
		return name.match(regex)
	def render
		<self>
			<input[bg:gray3 p:4 mx:auto d:block mb:3] placeholder="type" @keyup.filterFunction bind=query>
			<ResultsTwo bind:filteredArr=filteredArr>

tag ResultsTwo
	def render
		<self>
			<ul>
				for item in filteredArr
					<li> item
tag App
	css &
		bg:gray1
		d:block
		p:4
	prop engquery = ""
	prop chamquery = ""
	def getStuff
		dictionary = await window.fetch('data.json')
		data = await dictionary.json!
		console.log data
		return data
	# def mount
	# 	getStuff!
	def render
		<self[ff:sans fw:bold]>
			<SearchTwo>
			<ResultsTwo>
			# <NewSearch>
			# <SearchBar>
			# <Results bind:data=data>

imba.mount <App>