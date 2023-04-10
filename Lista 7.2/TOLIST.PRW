#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function TOLIST
    (long_description)
    @type  Function
    @author Giulliana Yamaguchi
    /*/
User Function TOLIST()
    
     Local cAlias := ('ZZT')
    Local cTitle := 'Cadastro de Tarefas'
    Local oBrowse := FwMBrowse():NEW()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)

    oBrowse:AddLegend("ZZT_STATUS == 'A'", "GREEN",  "Tarefa Concluída",         "1")
    oBrowse:AddLegend("ZZT_STATUS == 'B'", "YELLOW", "Tarefa em andamento",      "1")
    oBrowse:AddLegend("ZZT_STATUS == 'C'", "WHITE",  "Tarefa na fila",           "1")
 

    oBrowse:DisableDetails() 
    oBrowse:DisableReport() // Desabilida o botão "Imprimir"
    oBrowse:Activate()
Return  

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.TOLIST' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.TOLIST' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.TOLIST' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Exluir'     ACTION 'VIEWDEF.TOLIST' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    // Cria as estruturas a serem usadas no Modelo de Dados
    Local oModel := MPFormModel():NEW('TOLISTM')     
    Local oStruZZT := FWFormStruct(1,'ZZT')  
    Local oStruZZ1 := FwFormStruct(1, 'ZZ1')       

    // Adiciona ao modelo um componente de formulário
    oModel:AddFields('ZZTMASTER', ,oStruZZT)      
    oModel:AddGrid('ZZ1DETAIL', 'ZZTMASTER', oStruZZ1) 

    oModel:SetRelation('ZZ1DETAIL', {{'ZZ1_FILIAL', 'xFilial("ZZ1")'}, {'ZZ1_COD', 'ZZT_COD'}}, ZZ1->(INDEXKEY( 1 )))
    // Adicionar a descrição do Modelo de Dados
    oModel:SetDescription('Modelo de dados de Tarefas')

    // Adiciona a descrição dos componentes do Modelo de Dados
    oModel:GetModel('ZZTMASTER'):SetDescription('Formulario de tarefas')
    oModel:GetModel('ZZ1DETAIL'):SetDescription('Formulário de detalhes')

    oModel:SetPrimaryKey({'ZZT_COD', 'ZZ1_COD'})

Return oModel

Static Function ViewDef()
    
    // Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
    Local oModel := FwLoadModel('TOLIST')

    // Cria as estruturas a serem usadas na View
    Local oStruZZT := FWFormStruct(2, 'ZZT')
    Local oStruZZ1 := FwFormStruct(2, 'ZZ1')

    // Interface de visualização construída
    Local oView  := FwFormview():New()

    oView:SetModel(oModel)

    // Adiciona no nosso View um controle do tipo formulário (antiga Enchoice)
    oView:AddField('VIEW_ZZT',oStruZZT, 'ZZTMASTER')  
    oView:AddGrid('VIEW_ZZ1', oStruZZ1, 'ZZ1DETAIL')
         
    // Cria um "box" horizontal para receber cada elemento da view

    oView:CreateHorizontalBox('TAREFA', 40)
    oView:CreateHorizontalBox('DETALHES', 60)

    oView:SetOwnerView('VIEW_ZZT', 'TAREFA')
    oView:SetOwnerView('VIEW_ZZ1', 'DETALHES')
    
Return oView
