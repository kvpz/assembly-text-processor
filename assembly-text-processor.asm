.data 

dialog:		.asciiz "BEDFORD
Coward of France! how much he wrongs his fame, Despairing of his own arm's fortitude, To join with witches and the help of hell!

BURGUNDY
Traitors have never other company. But what's that Pucelle whom they term so pure?

TALBOT
A maid, they say.

BEDFORD
A maid! and be so martial!

BURGUNDY
Pray God she prove not masculine ere long, If underneath the standard of the French She carry armour as she hath begun.

TALBOT
Well, let them practise and converse with spirits: God is our fortress, in whose conquering name Let us resolve to scale their flinty bulwarks.

BEDFORD
Ascend, brave Talbot; we will follow thee.

TALBOT
Not all together: better far, I guess, That we do make our entrance several ways; That, if it chance the one of us do fail, The other yet may rise against their force.

BEDFORD
Agreed: I'll to yond corner.

BURGUNDY
And I to this.

TALBOT
And here will Talbot mount, or make his grave. Now, Salisbury, for thee, and for the right Of English Henry, shall this night appear How much in duty I am bound to both.

Sentinels
Arm! arm! the enemy doth make assault!

ALENCON
How now, my lords! what, all unready so?

BASTARD OF ORLEANS
Unready! ay, and glad we 'scaped so well.

REIGNIER
'Twas time, I trow, to wake and leave our beds, Hearing alarums at our chamber-doors.

ALENCON
Of all exploits since first I follow'd arms, Ne'er heard I of a warlike enterprise More venturous or desperate than this.

BASTARD OF ORLEANS
I think this Talbot be a fiend of hell.

REIGNIER
If not of hell, the heavens, sure, favour him.

ALENCON
Here cometh Charles: I marvel how he sped.

BASTARD OF ORLEANS
Tut, holy Joan was his defensive guard.

Enter CHARLES and JOAN LA PUCELLE

CHARLES
Is this thy cunning, thou deceitful dame? Didst thou at first, to flatter us withal,,Make us partakers of a little gain,,That now our loss might be ten times so much?

JOAN LA PUCELLE
Wherefore is Charles impatient with his friend! At all times will you have my power alike? Sleeping or waking must I still prevail, Or will you blame and lay the fault on me? Improvident soldiers! had your watch been good, This sudden mischief never could have fall'n.

CHARLES
Duke of Alencon, this was your default, That, being captain of the watch to-night, Did look no better to that weighty charge.

ALENCON
Had all your quarters been as safely kept As that whereof I had the government, We had not been thus shamefully surprised.

BASTARD OF ORLEANS
Mine was secure.

REIGNIER
And so was mine, my lord.

CHARLES
And, for myself, most part of all this night, Within her quarter and mine own precinct I was employ'd in passing to and fro, About relieving of the sentinels: Then how or which way should they first break in?

JOAN LA PUCELLE
Question, my lords, no further of the case, How or which way: 'tis sure they found some place But weakly guarded, where the breach was made. And now there rests no other shift but this; To gather our soldiers, scatter'd and dispersed, And lay new platforms to endamage them.

Soldier
I'll be so bold to take what they have left. The cry of Talbot serves me for a sword; For I have loaden me with many spoils, Using no other weapon but his name.

Exit

SCENE II. Orleans. Within the town.

Enter TALBOT, BEDFORD, BURGUNDY, a Captain, and others 

BEDFORD
The day begins to break, and night is fled, Whose pitchy mantle over-veil'd the earth. Here sound retreat, and cease our hot pursuit.

Retreat sounded

TALBOT
Bring forth the body of old Salisbury, And here advance it in the market-place, The middle centre of this cursed town. Now have I paid my vow unto his soul; For every drop of blood was drawn from him, There hath at least five Frenchmen died tonight. And that hereafter ages may behold What ruin happen'd in revenge of him, Within their chiefest temple I'll erect A tomb, wherein his corpse shall be interr'd: Upon the which, that every one may read, Shall be engraved the sack of Orleans, The treacherous manner of his mournful death And what a terror he had been to France. But, lords, in all our bloody massacre, I muse we met not with the Dauphin's grace, His new-come champion, virtuous Joan of Arc, Nor any of his false confederates.

BEDFORD
'Tis thought, Lord Talbot, when the fight began, Roused on the sudden from their drowsy beds, They did amongst the troops of armed men Leap o'er the walls for refuge in the field.

BURGUNDY
Myself, as far as I could well discern For smoke and dusky vapours of the night, Am sure I scared the Dauphin and his trull, When arm in arm they both came swiftly running, Like to a pair of loving turtle-doves That could not live asunder day or night. After that things are set in order here, We'll follow them with all the power we have.

Enter a Messenger

Messenger
All hail, my lords! which of this princely train Call ye the warlike Talbot, for his acts So much applauded through the realm of France?

TALBOT
Here is the Talbot: who would speak with him?

Messenger
The virtuous lady, Countess of Auvergne, With modesty admiring thy renown, By me entreats, great lord, thou wouldst vouchsafe To visit her poor castle where she lies, That she may boast she hath beheld the man Whose glory fills the world with loud report.

BURGUNDY
Is it even so? Nay, then, I see our wars Will turn unto a peaceful comic sport, When ladies crave to be encounter'd with. You may not, my lord, despise her gentle suit.

TALBOT
Ne'er trust me then; for when a world of men Could not prevail with all their oratory, Yet hath a woman's kindness over-ruled: And therefore tell her I return great thanks, And in submission will attend on her. Will not your honours bear me company?

BEDFORD
No, truly; it is more than manners will: And I have heard it said, unbidden guests Are often welcomest when they are gone.

TALBOT
Well then, alone, since there's no remedy, I mean to prove this lady's courtesy. Come hither, captain.

\n\n"

opening:		.asciiz "TALBOT"

.text
	.globl main

main:	
	la $a0, dialog
	li $v0, 4
	syscall

	la $a0, dialog
	la $a1, opening		
	jal cov_longest

	

	la $a0, dialog
	li $v0, 4
	syscall
	
#beq $v0, $0, done
done:	
	li $v0, 10		# Exit
	syscall


#------------------------------------------------
cov_longest:	#Accepts in $a0 the address asciiz string to be searched/ $a1 string storing opening:
	addiu $sp, $sp, -4			#prepare 4 bytes in the stack
	sw $ra, 0($sp)				#store $ra in stack for preservation
	jal name_length
	move $s2, $v0				#$s2=$v0==length of opening: (why not just set it directly to $s0 in previous function?)
	jal find_next_sentence		#finds next speech of character we’re looking for. Execute next instruction if a character was found
	beq $v0, $0, no_sentence	#if($v0==0)no sentence(end of dialogue); else there is something to read->
	la $s5, 0($v0)				#$s5= address of first byte in character’s name in dialogue
	jal get_to_end				#returns in $v0 length of speech 
	move $s7, $v0				#saves the length of the speech in $s7 for a comparison to previous length
	
comparison:
	jal find_next_sentence			
	beq $v0, $0, only_sentence
	la $t5, 0($v0)				#$t5= address of first byte in character’s name in dialogue
	jal get_to_end				#returns in $v0 length of speech 
	move $t8, $v0				#$t8 holds the length of the newest found speech
	bgt $t8, $s7, replace		#if newest speech is longer, replace/store its address in $s5 and length in $s7
	j comparison
	
replace:
	move $s7, $t8
	la $s5, 0($t5)
	j comparison
	
only_sentence:
	la $a0, 0($s6)				
	move $a1, $s7
	jal cov_str
	
no_sentence:	#This runs when there is no sentence in the dialogue: that matches the name
	lw $ra, 0($sp)			#restore $ra from stack
	addi $sp, $sp, 4		#remove allocation from stack
	li $v0, 0	
	jr $ra				
#------------------------------------------------
#------------------------------------------------
find_next_sentence:	#Accepts in $a0 the address asciiz string to be searched/ $a1 the address of opening:		
	li $t9, 0			#counter for the names
	
COUNT:
	lb $t0, 0($a0)				#load byte in dialogue: into $t0
	addi $a0, $a0, 1			#iterate through dialogue:
	beq $t0, 0x0a, NEWLINE		#stops counting once a newline has been reached
	addi $t9, $t9, 1			#increase counter
	j COUNT
	
NEWLINE:
	lb $t0, 0($a0)				#$t0=byte in sentence OR =another newline(which means that we are at the end of a speech OR dialogue!)
	bne $t0, 0x0a, CHARACTER	#if($t0!=’\n’)a character has been found. go to CHARACTER; else if no character was found->
	addi $a0, $a0, 1			#iterate once more through dialogue:
	lb $t0, 0($a0)				#If($t0=newline) end of dialogue:; else new name up ahead or some "interrupting" string
	beq $t0, 0x0a, EndOfDial	#if($t0==’\n’) EndOfDialogue; else->
	
	j NewSearchNL				#jumps because a character has been found(meaning that there is something after the previous speech)
	
CHARACTER:             		#checks if the character found matches the one in “name:”
	bne $t9, $s2, NewSearch    	#if(name lengths don’t match)NewSearch(so just iterate through speech until next character is found); else->
	
	sub $t2, $a0, $t9			#$t2=address of second byte of $a0
	lb $t0, 0($t2)				#$t0=SECOND byte in the character’s name 
	lb $t1, 1($a1)				#$t1=SECOND byte in “name:”	
	bne $t0, $t1, NewSearchChar #If(the first characters in names don’t match)NewSearchChar; else-> because names match!
	
	addi $t2, $t2, -1			#$t2=now points to the first byte in the name in dialogue:
	la $v0, 0($t2)				#$v0=address of first byte of the character’s name in dialogue:
	j FOUND			
	
NewSearch:					#called when the names don’t match
	add $t9, $0, $0				#reset counter
	j COUNT

NewSearchChar:				#called when the first character of the names don’t match
	add $t9, $0, $0				#$t9=0 ...reset counter--
	j COUNT						#go back to count to iterate through sentences

NewSearchNL:				#called if only 2 new lines had been found in NEWLINE since it was not a name
	add $t9, $0, $0				#$t9=0 reset counter
	j COUNT
	
EndOfDial:
	move $v0, $0        		#$v0=0 since end of dialogue and no name could be found
	
FOUND:						#called when there is a match in the character length/ runs when end of dialogue
	move $t9, $0 				#$t9 = 0 reset counter
	jr $ra						#jumps back to the next instruction in cov_longest. RETURNS $v0=first byte of character's name in dialogue
	
#------------------------------------------------
#------------------------------------------------
get_to_end: 	#accepts $a0=starting address of speech
	li $t7, 0			#length of speech counter
	lb $t0, 0($a0)		#current byte
	
iterateToEnd:	
	beq $t0, 0x0a, foundNewLine			#go to foundNewLine if current byte is a new line
	addi $t7, $t7, 1			#if current byte isn’t a carriage return add 1 to length
	addi $a0, $a0, 1			#points to the next byte
	lb $t0, 0($a0)				#t2 now has the current value of the next byte
	j iterateToEnd				#go to iterateToEnd
	
foundNewLine:
	addi $a0, $a0, 1			#a0 now points to next byte (it is either a char or another newline)
	lb $t0, 0($a0)				#t2 now has the current value of the next bit
	bne $t0, 0x0a, iterateToEnd			#go back to L1 if next byte isn’t a newline(return carriage); else->
	
	move $v0, $t7				#returns length of speech in #v0
	jr $ra						#length of speech gets returned in $v0

#------------------------------------------------
#------------------------------------------------
cov_str:	#accepts in $a0 the starting address of a speech
	li $t2, 97			#used as flag to identify if character is lowercase
	li $t9, 0			#counter to end the conversion
	la $a0, dialog
	add $a0, $0, $s5
	add $a1, $a1, $s2
	
toUpper:
	lb $t0, 0($a0)			#first byte of speech is stored in $t0
	bge $t9, $a1, FIN		#if counter matches the length of the speech terminate
	bge $t0, $t2, UP		#if lower case, goes to loop to convert to uppercase
	
	addi $a0, $a0, 1		#increment address
	addi $t9, $t9, 1		#increment counter
	j toUpper

UP:
	addi $t0, $t0, -32		#convert lowercase to uppercase
	sb $t0, 0($a0)			#store back as upper case
	addi $a0, $a0, 1		#increment adDress
	addi $t9, $t9, 1		#increment counter
	j toUpper

FIN:	
	jr $ra				
#------------------------------------------------
#------------------------------------------------
name_length:
	la $s1, opening		#load address of hardcoded character name
	li $t9, 0			#initiate counter
	
#counts ONLY the letters and not the 0 (which indicates the end of the word).
count: 
	lb $t1, 0($s1)			#load byte of current address of $s1
	addi $s1, $s1, 1		#increment address of $s1
	beq $t1, $0, NULL		#if null character is reached branch into NULL
	addi $t9, $t9, 1		#else increment counter
	
	j count					#rerun loop
	
NULL:
	move $v0, $t9			#return counter(length of opening:) in $v0 
	jr $ra					#goes to moves $s2, $v0

#--------------------------------------------------------------------

