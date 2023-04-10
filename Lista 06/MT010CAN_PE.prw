#Include "Protheus.ch"

/*/{Protheus.doc} MT010CAN
    1 – Crie um ponto de entrada que seja executado
na inclusão/alteração de produtos. O objetivo
desse PE é acrescentar o texto “Cad. Manual - ”
antes da descrição do produto.
o Ex: “Cad. Manual – Fone de Ouvido”
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return 
    @example
    (examples)
    @see (links_or_references)
    /*/


User Function MT010CAN()
    LOCAL nOpc := PARAMIXB[1]

    if (INCLUI .OR. ALTERA) .AND. nOpc == 1

        IF ExistBlock('DescProd')
            ExecBlock('DescProd',.F.,.F.)
        ENDIF

    ENDIF
Return 
