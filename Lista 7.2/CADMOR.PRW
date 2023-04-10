#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function CADMOR
    Cadastro de PROPRIETÁRIOS (ZZR) e Blocos (ZZM)
    @type  Function
    @author Giulliana
    @since 30/03/2023
    /*/
User Function CADMOR()

    Local cAlias := ('ZZM')
    Local cTitle := 'Cadastro de Bloco'
    Local oBrowse := FwMBrowse():NEW()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)

    oBrowse:DisableDetails() 
    oBrowse:DisableReport() //? Desabilida o botão "Imprimir"
    oBrowse:Activate()
Return 

Static Function MenuDef()

    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.CADMOR' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CADMOR' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CADMOR' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Exluir'     ACTION 'VIEWDEF.CADMOR' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()

    Local oModel   := MpFormModel():NEW('CADMORM')
    Local oStruZZM := FwFormStruct(1,'ZZM')
    Local oStruZZR := FwFormStruct(1, 'ZZR')
    
    oModel:AddFields('ZZMMASTER', ,oStruZZM)

    oModel:AddGrid('ZZRDETAIL', 'ZZMMASTER', oStruZZR)

    oModel:SetRelation('ZZRDETAIL', {{'ZZR_FILIAL', 'xFilial("ZZR")'}, {'ZZR_COD', 'ZZM_CODBLO'}}, ZZR->(IndexKey(1)))

    oModel:SetDescription('Modelo de dados de Bloco')

    oModel:GetModel('ZZMMASTER'):SetDescription('Formulário de Bloco')
    oModel:GetModel('ZZRDETAIL'):SetDescription('Formulário de Proprietário')

    oModel:SetPrimaryKey({'ZZM_CODBLO', 'ZZR_COD'})

Return oModel

Static Function ViewDef()

    Local oModel   := FwLoadModel('CADMOR')
    Local oStruZZR := FwFormStruct(2, 'ZZR') 
    Local oStruZZM := FwFormStruct(2, 'ZZM')
    
    Local oView    := FwFormview():New()

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZM', oStruZZM, 'ZZMMASTER')
    oView:AddGrid( 'VIEW_ZZR', oStruZZR, 'ZZRDETAIL')

    oView:CreateHorizontalBox('Bloco', 40)
    oView:CreateHorizontalBox('Proprietario', 60)

    oView:SetOwnerView('VIEW_ZZM', 'Bloco')
    oView:SetOwnerView('VIEW_ZZR', 'Proprietario')

RETURN oView

