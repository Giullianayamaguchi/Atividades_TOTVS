#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'


USER FUNCTION L3_E1_2()
    LOCAL oDLG
    Local nCont := 0
    
    rpcsetenv("99", "01")
    DBSELECTAREA("SC7")
    SC7->(DBSETORDER(1))
    SC7->(DBGOTOP())
        nCont := 0
        DEFINE DIALOG oDlg TITLE "Exemplo MsSelBr" FROM 0,0 TO 700,1270 PIXEL        
            oBrowse := MsSelBr():New( 1,1,1270,700,,,,oDlg,,,,,,,,,,,,.F.,'SC7',.T.,,.F.,,, )    
            oBrowse:AddColumn(TCColumn():New('pedido',{||nCont++ },,,,'LEFT',,.F.,.F.,,,,.F.,))    
            oBrowse:AddColumn(TCColumn():New('Codigo',{||SC7->C7_PRODUTO },,,,'LEFT',,.F.,.F.,,,,.F.,))    
            oBrowse:lHasMark := .T.
            oBrowse:bAllMark := {|| alert('Click no header da browse') }  

        ACTIVATE DIALOG oDlg CENTERED 

    SA1->(DBCLOSEAREA())

RETURN
