#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} Item
    9 – Crie um ponto de entrada que seja executado
na inclusão/alteração de produtos. O objetivo
desse PE é acrescentar o texto “Cad. Manual - ”
antes da descrição do produto.
o Ex: “Cad. Manual – Fone de Ouvido”
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return lRet, Logico, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function Item()
  Local aParam   := PARAMIXB
  Local lRet     := .T.
  Local oObj     := Nil
  Local cIdPonto := ''
  Local cIdModel := ''

  if aParam <> NIL
    oObj     := aParam[1]
    cIdPonto := aParam[2]
    cIdModel := aParam[3]
      
    if cIdPonto == 'MODELCOMMITTTS'
      IF ExistBlock('DescProd')
        ExecBlock('DescProd',.F.,.F.)
      ENDIF
    endif
  endif
Return lRet
