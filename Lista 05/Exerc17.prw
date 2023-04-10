/*  17 � Fazer um programa que trate de um array de 8
elementos num�ricos.
Ele dever� apresentar um menu que permitir� as
seguintes opera��es:
--- Carregar o array atrav�s da leitura dos valores.
--- Exibir o conte�do do array.
--- Classificar os valores em ordem crescente. Caso o
array esteja vazio, informar.
 Classificar os valores em ordem decrescente. Caso o
array esteja vazio, informar.
o Pesquisar a exist�ncia de um valor no array.
Caso o array esteja vazio, informar.
o Informar o somat�rio dos valores do array.
o Informar a m�dia dos valores do array.
o Informar o maior e o menor valor do array.
o Embaralhar o conte�do do array.
o Informar os valores que se repetem e a quantidade de
repeti��es. */




#INCLUDE 'TOTVS.CH'

USER FUNCTION L5_E17()
    LOCAL aArray := {}
    LOCAL nCont  := 0
    LOCAL nNum   := 0

    MSGINFO( "primeiro vamos preencher o array", "Preencher" )

    for nCont := 1 TO 8
        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "� n�mero do 1 array:  "))
        aadd(aArray, nNum)

    next

    Alternativa(aArray, nCont)


RETURN

Static Function Alternativa(aArray, nCont)
    
    LOCAL nOpcao := 0
    LOCAL cMsg   := ''
    LOCAL nPesq  := 0
    LOCAL nVez := 0
    LOCAL nCon    := 0
    LOCAL nSoma := 0
    LOCAL nTemp :=0
    
    FwAlertInfo("1  - Carregar o array atrav�s da leitura dos valores. " + CRLF+ ;
"1- Exibir o conte�do do array.  " + CRLF+ ;
"2- Classificar os valores em ordem crescente. Caso o array esteja vazio, informar. " + CRLF+ ;
"3- Classificar os valores em ordem decrescente. Caso o array esteja vazio, informar.  " + CRLF+ ;
"4- o Pesquisar a exist�ncia de um valor no array. Caso o array esteja vazio, informar. " + CRLF+ ;
"5- o Informar o somat�rio dos valores do array.  " + CRLF+ ;
"6- o Informar a m�dia dos valores do array. " + CRLF+ ;
"7- o Informar o maior e o menor valor do array. " + CRLF+ ;
"8- o Embaralhar o conte�do do array. " + CRLF+ ;
"9- o Informar os valores que se repetem e a quantidade de repeti��es.")

    nOpcao := Val(FwInputBox("Digite uma op��o: "))

    if nOpcao == 1
        for nCont := 1 to 8
            cMsg += 'Numero: ' + ALLTRIM(STR(aArray[nCont])) +CRLF
        NEXT
    
    elseif nOpcao == 2
        if aArray <> {}
        cMsg += 'ordem Crescente: ' 
            For nCont := 1 to len(aArray)
                    aSort(aArray)
                    cMsg +=  ALLTRIM(STR(aArray[nCont])) + " "
            NEXT
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF

        elseif nOpcao == 3
        if aArray <> {}
        cMsg += 'ordem Decrescente: ' 
            For nCont := 1 to len(aArray)
                    ASORT(aArray,,, { |x, y| x > y } )
                    cMsg +=  ALLTRIM(STR(aArray[nCont])) + " "
            NEXT

        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF

    elseif nOpcao == 4
         if aArray <> {}
        cMsg += 'Pesquisa: ' 
        nPesq := Val(FwInputBox("Digite um n�mero para pesquisar"))

           for nCont := 1 to 8
                for nCon := nCont + 1 to 8
                    if aArray[nCont] == aArray[nCon]       
                        nVez++ 
                        cMsg := 'O n�mero ' + alltrim(str(nPesq))+ ' se encontra nas posi��es ' + ALLTRIM(STR(nCont)) + ' e '+ ALLTRIM(STR(nCon)) + CRLF
                    endif
                next
            next
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF


    elseif nOpcao == 5
         if aArray <> {}
            cMsg += 'Somat�ria: ' 
    
           for nCont := 1 to 8
                nSoma += aArray[nCont]
                cMsg := 'A soma � de '+ ALLTRIM(STR(nSoma)) + CRLF
            NEXT 
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF

        elseif nOpcao == 6
         if aArray <> {}
            cMsg += 'M�dia: ' 
    
           for nCont := 1 to 8
                nSoma += aArray[nCont]
                cMsg := 'A soma � de '+ ALLTRIM(STR(nSoma/ 8)) + CRLF
            NEXT 
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF


    elseif nOpcao == 7
         if aArray <> {}
           For nCont := 1 to len(aArray)
                    aSort(aArray)
            NEXT
            cMsg += "maior " +ALLTRIM(STR(aArray[8]) + "Menor: " +alltrim(str(aArray[1])))
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF

    elseif nOpcao == 8
         if aArray <> {}
         cMsg += "embaralhar: "
            for nCont :=  len(aArray) to 1 STEP -1
                nCon := RANDOMIZE( 1, len(aArray))
                nTemp := aArray[nCon]
                if nCont <> nCon
                    aArray[nCon] := aArray[nCont]
                    aArray[nCont] := nTemp
                endif
        NEXT
        For nCont := 1 to LEN(aArray)
            cMsg  += ('O ' + ALLTRIM(STR(nCont)) + '� valor � ' + ALLTRIM(STR(aArray[nCont]))) + CRLF + CRLF 
        Next
        
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF


    elseif nOpcao == 9
         if aArray <> {}
        cMsg += 'Repetidos: ' 

           for nCont := 1 to 8
                for nCon := nCont + 1 to 8
                    if aArray[nCont] == aArray[nCon]       
                        nVez++ 
                        cMsg := 'O n�mero ' + alltrim(str(aArray[nCont]))+ 'se repete ' + alltrim(str(nVez)) + CRLF
                    endif
                next
            next
        else 
            FwAlertInfo("Array vazio")
            RETURN
        ENDIF

    ENDIF

    
    FwAlERTSucess(cMsg)
RETURN
