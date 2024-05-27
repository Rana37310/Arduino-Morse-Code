; followin; following lines use .equ to specify equivalent symbols
.equ SREG, 0x3f    ; Status register. See data sheet, p.11
.equ DDRB, 0x04    ; Register defining pins on port B to be input (0) or output (1)
.equ DDRD, 0x0A    ; Register defining pins on port B to be input (0) or output (1)
.equ PORTB, 0x05   ; Output port for PORTB
.equ PORTD, 0x0B   ; OUTPUT PORT FOR PORTD
.org 0             ; .org specifies the start address

          ; reset system status
main:     ldi r16, 0    ; ldi - load immediate. this sets register 16 to zero
	  ldi r17, 0

          out SREG,r16    ; copy register 16 to SREG, essentially set SREG to zero
          out SREG,r17

	; set port bits to output mode
          ldi r16, 0x0F   ; set r16 to 0x01 -> switch on bit 0 -> bit 0 is an output
          out DDRB,r16    ; copy the value to DDRB
          
          ldi r17, 0xF0
          out DDRD, r17
          
          ; turn LED ON   

mainloop:  

;Question 1  displaying k21172191

         
         ; Displaying 2
         
          ldi r16, 0x02
          ldi r17, 0x00
          ; write register 16 to portB 
          out PORTB, r16
        
          
          ; Delaying for 1 s { delay method delays for 0.5s}
           call delay
           call delay
           

          ; Displaying 1
          
          ldi r16, 0x01
 
          ; write register 16 to portB 
          out PORTB, r16
            
	  ; Delaying for 1 s { delay method delays for 0.5s}
	  call delay
          call delay
           
           ; Displaying 1
           
	   ldi r16, 0x01

          ; write register 16 to portB and portD
          out PORTB, r16
 
	  ; Delaying for 1 s { delay method delays for 0.5s}	  
	  call delay
          call delay
          
          
           ; Displaying 7
               
           ldi r16, 0x07
          ; write register 16 to portB 
          out PORTB, r16
          
          ; Delaying for 1 s { delay method delays for 0.5s}        
          call delay
          call delay
          
           ; Displaying 2
           
           ldi r16, 0x02
          ; write register 16 to portB 
          out PORTB, r16

          ; Delaying for 1 s { delay method delays for 0.5s} 
          call delay
          call delay
          
          ; Displaying 1
          
           ldi r16, 0x01  
          ; write register 16 to portB
          out PORTB, r16
      
           ; Delaying for 1 s { delay method delays for 0.5s} 
          call delay
          call delay
          
          ; Displaying 9
          
           ldi r16, 0x09
          ; write register 16 to portB 
          out PORTB, r16
 
           ; Delaying for 1 s { delay method delays for 0.5s}           
          call delay
          call delay
          
           ; Displaying 1
           
           ldi r16, 0x01
          ; write register 16 to portB and portD
          out PORTB, r16
          
           ; Delaying for 1 s { delay method delays for 0.5s}          
          call delay
          call delay
          
          
;Question 2 displaying R.A
          
         
          
          ;R=18 
          
          ldi r16, 0x02
          ldi r17,0x10

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
           ; Delaying for 1 s { delay method delays for 0.5s} 
          call delay
          call delay
          
          ;.=27
          
          ldi r16, 0x0B
          ldi r17,0x10

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
	
	   ; Delaying for 1 s { delay method delays for 0.5s} 
          call delay
          call delay
          
          
          ;A=1
          
          ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
           ; Delaying for 1 s { delay method delays for 0.5s} 
          call delay
          call delay
          
          
         


;Question 3

;Displaying normalOrder:RAN if the number is even and ReverseNumber: NAR if the number is odd 

;Note --> dot: is displaying one led , dash: is displaying all the leds 

question3:

; Setting the tracking loop r20
	  ldi r20 ,50
	  
; Setting the tracking of modulo five r21
	  ldi r21,50
	  
loop:	 
	mov r25,r20
	
	;Odd= 0001 , Even= 0000
	andi r25, 0x01
	
	;Checking if the number is odd
	cpi r25,1
	breq task1        
	
	;Checking if the number is even
	cpi r25,0
	breq task2
			  	     
q3JumpA: 
	;Checking if the number is modolu five
         cp r20,r21
	 breq fiveDots

q3JumpB:
	;Inter-word spacing  
	call delay1.4
	
	;Decrease the r20 with one 
	  dec r20
	  
	 ;Compare r20 with 0
          cpi r20, 0
          brne loop
          
     



;Question 4 Ping-Pong

;Note --> shifting is only on portB 
question4:

; Shift to the left the first pin until the last pin of the portB	
	  call ShiftToLeft
	  
; Shift to the right the last pin until the first pin of the portB
	  call	ShiftToRight

;Loop infinitely to the question 4 
rjmp question4



rjmp mainloop



;Methods 

; Question 4 Ping-Pong methods:

ShiftToLeft:

; r16 : Turning on the first led, r26: Tracking the loop 
	 ldi r16,1
	 ldi r26,1

loop4A:
          ; write register 16 to portB 
          out PORTB, r16
   
          ;Delaying for 1.4 s        
          call delay1.4
          
           ;Shift to the left
           lsl r16

          ;write register 16 to portB 
          out PORTB, r16
 
          ;Delaying for 1.4 s        
          call delay1.4  
          
          ;Increase one to the r26
          inc r26
	  
	  ;Compare r26 to 4 if it's less call loop4A .
	  cpi r26,4
	  brne loop4A
	  ret

	  
ShiftToRight:

; r16 : Turning on the last led, r26: Tracking the loop 
	  ldi r16,8
	  ldi r26,1
	  	  
loop4B:
          ; write register 16 to portB 
          out PORTB, r16
   
         ;Delaying for 1.4 s       
          call delay1.4
          
          ;Shift to the right
           lsr r16

          ; write register 16 to portB 
          out PORTB, r16
 
          ;Delaying for 1.4 s
          call delay1.4  
          
          ;Increase one to the r26
          inc r26
	  
	  ;Compare r26 to 4 if it's less call loop4A
	  cpi r26,4
	  brne loop4B
	  ret



;Question 3 methods:

; The purpose of writing branches (task 1, task2)  is to avoid the error 'no symbol'
task1:	
	call normalOrder
         
         rjmp q3JumpA
     
task2: 	
	 call reverseOrder
         rjmp q3JumpA

fiveDots:
          
;Inter-part spaceing (after N or R) since there is not delaying in the end of both methods ( normalOrder,reverseOrder)

	call delay0.2
	
;Loop tracking r26
 
 	  ldi r26,5
 	  
; Turn on and off the led , decrease r21 ( modulo five) and r26 --> 5 times
loop3:
	
	   ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Dot spacing 
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Dot spacing 
          call delay0.2
          
        ;Decrease r21,r26 by 1
        
          dec r21
          dec r26
          cpi r26,0
          brne loop3
       
       ; After finshing the loop, the program return to Q3
       rjmp q3JumpB




;Delaying methods:

;Note --> The reference of the delay (0.5 sec) method is from Josh Murphy 

;delay for 0.5 sec
delay:     nop        ; 1 cycle
          dec r17    ; 1 cycle
          cpi r17, 0 ; 1 cycle
          brne delay ; 2 cycles
          ldi r17, 255 ; reset inner loop
          dec r18
          cpi r18, 0
          brne delay
          ldi r18, 21 ; reset first outer loop
          dec r19
          cpi r19, 0
          brne delay
          ret
          
;delay for 0.2 sec (200ms)

delay0.2:  ldi r17, 255 ; 255
          ldi r18, 255 ; 255
          ldi r19, 10 ; 25
          ; inner loop is 5 cycles so delay is - 
          ; 5 cycles * 255 * 255 * 10 = 3251250 cycles
          ; 3251250 cycles / 16,000,000 = 0.20323251250 seconds 
loop1:    nop        ; 1 cycle
          dec r17    ; 1 cycle
          cpi r17, 0 ; 1 cycle
          brne loop1 ; 2 cycles when branching
          ldi r17, 255 ; reset inner loop
          dec r18
          cpi r18, 0
          brne loop1
          ldi r18, 255 ; reset first outer loop
          dec r19
          cpi r19, 0
          brne loop1
          ret
          
;delay for 0.6 sec (600ms)

delay0.6:  ldi r17, 255 ; 255
          ldi r18, 255 ; 255
          ldi r19, 30 ; 25
          ; inner loop is 5 cycles so delay is - 
          ; 5 cycles * 255 * 255 * 30 = 9753750 cycles
          ; 9753750 cycles / 16,000,000 = 0.60969753750 seconds 
loop2:    nop        ; 1 cycle
          dec r17    ; 1 cycle
          cpi r17, 0 ; 1 cycle
          brne loop2 ; 2 cycles when branching
          ldi r17, 255 ; reset inner loop
          dec r18
          cpi r18, 0
          brne loop2
          ldi r18, 255 ; reset first outer loop
          dec r19
          cpi r19, 0
          brne loop2
          ret

;dealying for inter-word space 1.4
delay1.4: 
          call delay0.6
          call delay0.6
          call delay0.2
          ret

;Morse Code Methods:

normalOrder:  ;Ran 
          
          ;R           
          ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part spacing 
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part spacing 
           call delay0.2
           
          ldi r16, 0x0f
          ldi r17,0xf0

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;Inter-letter spacing 
          call delay0.6   
           
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
           
          ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x01
          ldi r17,0x00
         ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00
         ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-letter spacing 
          call delay0.6
          
          
          ;a

          ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x0f
          ldi r17,0xf0

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
           ;Dash
          call delay0.6 
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
           ;Inter-letter spacing 
          call delay0.6
              
          ;n
          
          ldi r16, 0x0f
          ldi r17,0xf0

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
           ;Dash
          call delay0.6
          
           ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ; the time spacing would be hold in the question 3
          
          ret
          
reverseOrder:
	     ;Nar
	     
	     ;n
	   ldi r16, 0x0f
          ldi r17,0xf0

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;Dash
          call delay0.6
          
           ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
           ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
           ;Inter-part spacing
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;inter-letter space 
          call delay0.6
          
           ;a

          ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          call delay0.2
          
          ldi r16, 0x0f
          ldi r17,0xf0

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;Dash
          call delay0.6 
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;delaying for inter-letter space
          call delay0.6
          
          ;r
	   ldi r16, 0x01
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part delaying
           call delay0.2
           
          ldi r16, 0x0f
          ldi r17,0xf0

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17 
          
          ;Dash
          call delay0.6   
           
          ldi r16, 0x00
          ldi r17,0x00

          ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part delaying
          call delay0.2
          
          ldi r16, 0x01
          ldi r17,0x00
         ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ;Inter-part delaying
          call delay0.2
          
          ldi r16, 0x00
          ldi r17,0x00
         ; write register 16 to portB and portD
          out PORTB, r16
          out PORTD, r17
          
          ; the time spacing would be hold in the question 3
          
	  ret
	  



