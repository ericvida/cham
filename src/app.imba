import 'imba/preflight.css'
global css html	w:100% h:100% m:0 ff:sans
global css body w:100% h:100% m:0
import * as dictionary from './data.json'
import {VidaSearch} from './VidaSearch'

tag close-icon
	<self[d:block]>
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">
			<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z">

tag shuffle-icon
	<self>
		<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-shuffle" viewBox="0 0 16 16">
			<path fill-rule="evenodd" d="M0 3.5A.5.5 0 0 1 .5 3H1c2.202 0 3.827 1.24 4.874 2.418.49.552.865 1.102 1.126 1.532.26-.43.636-.98 1.126-1.532C9.173 4.24 10.798 3 13 3v1c-1.798 0-3.173 1.01-4.126 2.082A9.624 9.624 0 0 0 7.556 8a9.624 9.624 0 0 0 1.317 1.918C9.828 10.99 11.204 12 13 12v1c-2.202 0-3.827-1.24-4.874-2.418A10.595 10.595 0 0 1 7 9.05c-.26.43-.636.98-1.126 1.532C4.827 11.76 3.202 13 1 13H.5a.5.5 0 0 1 0-1H1c1.798 0 3.173-1.01 4.126-2.082A9.624 9.624 0 0 0 6.444 8a9.624 9.624 0 0 0-1.317-1.918C4.172 5.01 2.796 4 1 4H.5a.5.5 0 0 1-.5-.5z"/>
			<path d="M13 5.466V1.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192zm0 9v-3.932a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192z"/>


import {dict} from './dict.imba'

tag json-results
	prop query = ''
	def render
		<self[p:6 d:block bg:gray8 c:gray3]>
			<pre> "export let dict = ["
				for dictItem, itemindex in dict
					<div>
						for engItem in dictItem.engArray when VidaSearch(query, "{engItem.engWord}")
								<div>
									if itemindex isnt 0
										<pre> "	---"
									<code[d:block]>
										<pre> 	"	wordCham: \"{dictItem.wordCham}\""
										<pre> 	"	wordIpa: \"{dictItem.wordIpa}\""
										<pre>
											if dictItem.wordReviewed is "✅"
												"	wordReviewed: true"
											else
												"	wordReviewed: false"
										<pre> 	"	wordNotes: \"{dictItem.wordNotes}\""
									for engItem, index in dictItem.engArray
										<div[d:block]>
											let grouplength = dictItem.engArray.length
											if dictItem.engArray.indexOf(engItem) >= 1
												<pre> "		---"
											else
												<pre> 	"	engArray: ["
											<pre> 	"		engWord: \"{engItem.engWord}\""
											<pre> 	"		engInfo: \"{engItem.engInfo}\""
											<pre>	"		engUse: \"{engItem.engUse}\""
											if (index + 1) is grouplength
												<pre> 	"		]"
									for khItem, index in dictItem.khArray
										let grouplength = dictItem.khArray.length
										<div[d:block]>
											if VidaSearch(query, khItem.khWord)
												if dictItem.khArray.indexOf(khItem) >= 1
													<pre> "		---"
												else
													<pre> 	"	khArray: ["
												<pre> 	"		khWord: \"{khItem.khWord}\""
												<pre> 	"		khInfo: \"{khItem.khInfo}\""
												<pre>	"		khUse: \"{khItem.khUse}\""
												if (index + 1) is grouplength
													<pre> 	"		]"
				<pre> "]"
tag word-item
	def render
		<self>
			css bg:warm0 d:block px:6 min-height:100vh
			let index = route.params.id
			let engWords = dict[index].engArray
			let chamWord = dict[index].wordCham
			css 
				d:flex 
				fld:column
			for word in engWords
				# WORD CARD
				<div>
					css 
						d:flex 
						pos:relative
						fld:column 
						bg:white 
						bxs:sm, lg 
						px:6 
						pr:14
						py:6
						mb:6
						rdt:none @not-first:xl
						rdb:xl
						of:hidden
					
					# Word Card Header
					<div> 
						css 
							ai:baseline 
							d:flex 
							flw:wrap 
							bdb:2px solid indigo0

						<h2> 
							css fs:xl fw:bold mr:1
							"{word.engWord} " 
						<h2.chamWord> 
							css c:indigo4 fs:xl mr:1 ff:monospace
							"[{chamWord}] "
						<span.engUse> 
							css c:warm4 fw:bold fs:xl
							"{word.engUse}"

					# Word Info
					<div> 
						<p[fs:sm d:block]> "{word.engInfo}"
					
					# Close Card Button
					<a route-to="/list"> 
						css tween:all .2s
							bg:indigo0 @hover:indigo5
							h:100%
							pos:absolute 
							d:flex jc:center ai:center
							r:0 t:0
							fill:indigo2
							cursor:pointer
							>>> svg size:50px
						<close-icon>
tag word-list
	def scrollToTop
		window.scrollTo(0,0)
	def render
		<self>
			css bg:warm0 d:block px:6 min-height:100vh
			<div >
				css bg:white px:3 pt:6 pb:4 bxs:sm, xxl cursor:pointer rdb:xl
				for dictItem, itemIndex in dict
					<div route-to="/word/{itemIndex}/" @click.scrollToTop>
						for engItem, engIndex in dictItem.engArray when VidaSearch(query, engItem.engWord)
							<div[bdb:2px solid warm1 @hover:2px solid white px:3 py:2 fw:500 c:warm9 bg:white @hover: gray1]>
								<a><h1> engItem.engWord								
tag app-root
	# PROPS
	prop query = ''
	prop randomNum = 1
	def createRandomNum
		return randomNum = Math.floor(Math.random() * Math.floor(dict.length))
	def render
		<self[d:block]>
			<header>
				css p:6 pt:2 bg:gray9
				<h1[c:white ta:center pb:2 ff:sans tt:uppercase]> 
					<a route-to="/list"> "English to Cham Dictionary"
				<div[d:flex]>
					# Search Bar
					<input route-to="/list" placeholder="Type to Search:"  bind=query>
						css px:6 py:3 rdl:sm flg:1 h:50px bd:0
							border: 0px solid;
							mr:-1px
					
					# Shuffle button
					<button alt="random word" route-to="/word/{randomNum}" @click.createRandomNum>
						css 
							size:50px
							rdr:sm
							p:3
							bg:indigo1 @hover: indigo5
							c:indigo3
							bd:0px solid
						<shuffle-icon>
			<section.results>
				<word-list route="/list" bind:query=query>
				<word-item route="/word/:id" >
				<json-results route="/json" bind:query=query>
			<footer>
				css bg:gray7 c:white p:4
				<span> "Created by Eric Vida, All rights reserved. "
				<a[ta:center c:indigo2 td@hover:underline] route-to="/json"> "See Data"

imba.mount <app-root>