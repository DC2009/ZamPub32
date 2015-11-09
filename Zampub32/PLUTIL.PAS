unit Plutil;

interface

uses Dialogs;

type
{Buttons}
  TPlMsgDlgBtn = (mbTak, mbNie, mbOk, mbAnuluj, mbPomoc, mbWszystko);
  TPlMsgDlgButtons = set of TPlMsgDlgBtn;

const
{Dates}
  plShortDayNames:array[1..7] of string[3]=
                  ('Nie','Pon','Wto','Œro','Czw','Pi¹','Sob');

  plLongDayNames:array[1..7] of string[15]=
                 ('Niedziela','Poniedzia³ek','Wtorek','Œroda','Czwartek','Pi¹tek','Sobota');

  plLongMonthNames:array[1..12] of string[15]=
                   ('Styczeñ','Luty','Marzec','Kwiecieñ','Maj','Czerwiec','Lipiec',
                    'Sierpieñ','Wrzesieñ','PaŸdziernik','Listopad','Grudzieñ');

  plShortMonthNames:array[1..12] of string[3]=
                    ('Sty','Lut','Mar','Kwi','Maj','Cze','Lip','Sie','Wrz','Pa¿','Lis','Gru');

  implementation

end.
