#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} CUSTOMERVENDOR
    6 � No Cadastro de Fornecedores, utilizando um
Ponto de Entrada, ao tentar incluir ou alterar um
cadastro, fa�a as seguintes valida��es:
o Se o campo �Pa�s� estiver em branco n�o
poder� realizar a inclus�o / altera��o.
o Se o pa�s for �Brasil� (105), o campo �CNPJ�
dever� ser preenchido, caso n�o seja, n�o
poder� realizar a inclus�o / altera��o.
o Se o pa�s n�o for �Brasil�, o CNPJ n�o �
obrigat�rio.
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

User Function CUSTOMERVENDOR()

  Local aParam   := PARAMIXB 
  Local oObj  := NIL
  Local cIdPonto := ''
  Local cIdModel := ''
  Local lRet := .T.

  if aParam <> NIL 
    oObj := aParam[1]
    cIdPonto := aParam[2]
    cIdModel := aParam[3]
    if cIdPonto == 'MODELPOS'
      if Empty(M->A2_PAIS) // Verifica se o campo "Pa�s" est� preenchido, se n�o estiver, entrar� no if e retonar� o valor .F. para o PE.
        lRet := .F.
        Help(NIL, NIL, 'O campo <b>Pa�s</b> deve ser preenchido.', NIL, 'Pa�s n�o seleciondo', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Selecione o Pa�s'})
      elseif M->A2_PAIS $ '105' .AND. Empty(M->A2_CGC) // Verifica se o campo "Pa�s" est� preenchido, com o valor "105", e o caompo CNPJ est� preenchido, se estiver entrar� no if e retonar� o valor .F. para o PE.
        lRet := .F.
        Help(NIL, NIL, 'O campo <b>CNPJ</b> deve ser preenchido.', NIL, 'Campo CNPJ n�o foi preenchido', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Preencha o CNPJ do cliente.'}) 
      endif
    ENDIF
  ENDIF

Return lRet
