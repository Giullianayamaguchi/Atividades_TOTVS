#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

    /*/{Protheus.doc} User Function CADINST
    Cadastro de alunos 
    @type  Function
    @author user
    @since 27/03/2023
    /*/

User Function CADINST()
    Local cAlias  := 'ZZI'
    Local cTitle  := "Cadastro de Instrutor"
    Local oBrowse := FwMBrowse():New()   

    Local oMark   := FWMarkBrowse():New() 
    
    oMark:AddButton('Excluir Marc.',   'U_Deleta', 5, 1)
    
    oBrowse:SetAlias(cAlias) 
    oMark:SetFieldMark('ZZI_MARK')
    oBrowse:SetDescription(cTitle)        

    oBrowse:DisableDetails()   
    oBrowse:DisableReport()
    
    oBrowse:ACTIVATE()
Return 

STATIC FUNCTION MenuDef()
    Local aRotina :={}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CADINST' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CADINST' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Exluir'     ACTION 'VIEWDEF.CADINST' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()

    // Cria as estruturas a serem usadas no Modelo de Dados
    Local bModelPro := {|oModel|MdlProVld(oModel) }
    Local oModel := MPFormModel():NEW('CADINSTM',, bModelPro)     
    Local oStruZZI := FWFormStruct(1,'ZZI')         

    // Adiciona ao modelo um componente de formul�rio
    oModel:AddFields('ZZIMASTER', ,oStruZZI)       

    // Adiciona a descri��o do Modelo de Dados
    oModel:SetDescription('Modelo de dados de clientes')

    // Adiciona a descri��o dos Componentes do Modelo de Dados
    oModel:GetModel('ZZIMASTER'):SetDescription('Formulario de clientes')

    oModel:SetPrimaryKey({'ZZI_COD'})

Return oModel

Static Function ViewDef()
     // Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
    Local oModel := FwLoadModel('CADINST')

    // Cria as estruturas a serem usadas na View
    Local oStruZZI := FWFormStruct(2, 'ZZI')

    // Interface de visualiza��o constru�da
    Local oView  := FwFormview():New()

    oView:SetModel(oModel)

    // Adiciona no nosso View um controle do tipo formul�rio (antiga Enchoice)
    oView:AddField('VIEW_ZZI',oStruZZI, 'ZZIMASTER')       

    // Cria um "box" horizontal para receber cada elemento da view
    oView:CreateHorizontalBox('TELA', 100)
    oView:SetOwnerView('VIEW_ZZI', 'TELA')
    
Return oView

Static Function MdlProVld(oModel)
    Local lValid := .T.
    Local nOpc := oModel:GetOperation()
    Local cEsc := AllTrim(oModel:GetValue('ZZIMASTER', 'ZZI_ESCOLA'))
    Local cIda := (oModel:GetValue('ZZIMASTER', 'ZZI_NASC'))
    Local cHab := (oModel:GetValue('ZZIMASTER', 'ZZI_HABILI'))

    IF nOpc == 3
        IF DateDiffYear(cIda, DATE())< 21 
            lValid := .F.
            help(,,'erro',,'Favor revisar as informa��es referente a Ensino', 1, 0,,,,,,{'Necess�rio ter conclu�do ensino M�dio'})

        Elseif DateDiffYear(cHab, DATE())< 2
            lValid := .F.
            help(,,'erro',,'Favor revisar as informa��es', 1, 0,,,,,,{'Necess�rio estar habilitado h� 2 anos, no m�nimo'})

        Elseif cEsc == '1-Ensino Fundamental'
            lValid := .F.
            help(,,'erro',,'Favor revisar as informa��es',1,0  ,,,,,,{'Necess�rio ter atingido a maioridade (21 anos)'})
           
        ENDIF
    ENDIF
Return lValid

User Function Deleta()
  if MsgYesNo('Confirma a exclus�o dos cursos selecionados?')
    DbSelectArea('ZZC')
    
    ZZC->(DbGotop())
    
    while ZZC->(!EOF())
      if oMark:IsMark()   //? Verifica se o registro est� marcado
          RecLock('ZZC', .F.)
            ZZC->(DbDelete()) //? Marca o registro como Deletada (D_E_L_E_T_ = '*')
          ZZC->(MSUnlock())
      endif
      ZZC->(DbSkip())
    enddo
  endif
  //? Executa a atualiza��o das informa��es no Browse
  oMark:Refresh(.T.) //? .T. Indica que dever� ser posicionado no primeiro registro do Browse
Return
