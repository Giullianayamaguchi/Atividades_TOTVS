#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} CUSTOMERVENDOR
    6 – No Cadastro de Fornecedores, utilizando um
Ponto de Entrada, ao tentar incluir ou alterar um
cadastro, faça as seguintes validações:
o Se o campo “País” estiver em branco não
poderá realizar a inclusão / alteração.
o Se o país for “Brasil” (105), o campo “CNPJ”
deverá ser preenchido, caso não seja, não
poderá realizar a inclusão / alteração.
o Se o país não for “Brasil”, o CNPJ não é
obrigatório.
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
      if Empty(M->A2_PAIS) // Verifica se o campo "País" está preenchido, se não estiver, entrará no if e retonará o valor .F. para o PE.
        lRet := .F.
        Help(NIL, NIL, 'O campo <b>País</b> deve ser preenchido.', NIL, 'País não seleciondo', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Selecione o País'})
      elseif M->A2_PAIS $ '105' .AND. Empty(M->A2_CGC) // Verifica se o campo "País" está preenchido, com o valor "105", e o caompo CNPJ está preenchido, se estiver entrará no if e retonará o valor .F. para o PE.
        lRet := .F.
        Help(NIL, NIL, 'O campo <b>CNPJ</b> deve ser preenchido.', NIL, 'Campo CNPJ não foi preenchido', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Preencha o CNPJ do cliente.'}) 
      endif
    ENDIF
  ENDIF

Return lRet
