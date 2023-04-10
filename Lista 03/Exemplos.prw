#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

User Function ShowCliGen()
  Local aArea  := GetArea()
  Local cCod   := ''
  Local cNome  := ''
  Local cFant  := ''
  Local cMsg   := ''
  Local nCont  := 0
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES '' MODULO 'COM'
  DbSelectArea('SA1')
  DbSetOrder(1)
  DbGoTop()
  
  
  while SA1->(!EOF())
    cCod  := SA1->A1_COD
    cNome := SA1->A1_NOME
    cFant := SA1->A1_NREDUZ
    cMsg += 'Código: ' + cCod + CRLF + 'Nome: ' + cNome + CRLF + 'Nome Fantasia: ' + cFant + CRLF
    cMsg += '------------------------------' + CRLF + CRLF
    nCont++
    if nCont == 10
      FwAlertInfo(cMsg, 'Dados dos Clientes')
      nCont := 0
      cMsg  := ''    
    endif
    DbSkip()
  end
  if nCont > 0
    FwAlertInfo(cMsg, 'Dados dos Clientes')
  endif
  DbCloseArea()
  RestArea(aArea)
Return

USER FUNCTION BANCODEDADOS()
  LOCAL oDLG 

  rpcsetenv("99", "01")
  DBSELECTAREA("SA1")
  SA1->(DBSETORDER(1))
  SA1->(DBGOTOP())

    DEFINE DIALOG oDlg TITLE "Exemplo MsSelBr" FROM 0,0 TO 720,1280 PIXEL        
        oBrowse := MsSelBr():New( 1,1,1270,700,,,,oDlg,,,,,,,,,,,,.F.,'SA1',.T.,,.F.,,, )    
        oBrowse:AddColumn(TCColumn():New('Codigo',{||SA1->A1_COD },,,,'LEFT',,.F.,.F.,,,,.F.,))    
        oBrowse:AddColumn(TCColumn():New('Nome'  ,{||SA1->A1_NOME},,,,'LEFT',,.F.,.F.,,,,.F.,))    
        oBrowse:AddColumn(TCColumn():New('NReduz'  ,{||SA1->A1_NREDUZ},,,,'LEFT',,.F.,.F.,,,,.F.,))	    
        oBrowse:lHasMark := .T.
        oBrowse:bAllMark := {|| alert('Click no header da browse') }  

    ACTIVATE DIALOG oDlg CENTERED 

  SA1->(DBCLOSEAREA())

RETURN
