tableextension 50112 CustomerExt extends Customer
{
    fields
    {
        field(50100; LanguageId; Integer)
        {
            Caption = 'Language Id';
            TableRelation = Language."Windows Language ID";
            ValidateTableRelation = false;
        }
        field(50101; Date; Date)
        {
            Caption = 'Test Date';
        }
        field(50102; FormattedDate; Text[20])
        {
            Caption = 'Formatted Date';
        }
    }
}

pageextension 50112 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field(Date; Rec.Date)
            {
                ApplicationArea = All;
                Caption = 'Test Date';

                trigger OnValidate()
                begin
                    Rec.LanguageId := 0;
                    Rec.FormattedDate := '';
                end;
            }
            field(LanguageId; Rec.LanguageId)
            {
                ApplicationArea = All;
                Caption = 'Language Id';

                trigger OnValidate()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if Rec.LanguageId = 0 then
                        Rec.FormattedDate := ''
                    else
                        Rec.FormattedDate := TypeHelper.FormatDate(Rec.Date, Rec.LanguageId);
                end;
            }
            field(FormattedDate; Rec.FormattedDate)
            {
                ApplicationArea = All;
                Caption = 'Formatted Date';
                Editable = false;
            }
        }
    }
}
