#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC28()
    LOCAL aNome := {}
    LOCAL nCont := 0
    LOCAL cNome :=""
    LOCAL nI    := 0
    LOCAL cComp :=""

    while nCont <4
        cNome := fwinputbox("Digite um nome: ")
        aadd(aNome, cNome)

    nCont++
    ENDDO
    
    cComp := FWINPUTBOX("Digite o nome para comparação")
    for nI := 1 to len(aNome)
        if aNome == LEN(nComp)
            fwalertsucess("ACHEI!!")

        else
            fwalertinfo ("NÃO ACHEI!")
        ENDIF

    next

RETURN
