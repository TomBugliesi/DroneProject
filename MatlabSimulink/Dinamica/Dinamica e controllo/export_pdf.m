function export_pdf(figure,name)

% save selected figure with name 'name'

f = figure;

if iscell(name)

    name = string(name);

elseif ischar(name)

else

    error('name is not a cell or string array')

end


f.Name = name;

f.Units = 'normalized';

f.OuterPosition = [0 0 0.5 0.5]; %change this value to change papersize output
% 
% set(gca,'FontSize',19);
% 
% set(gca,'OuterPosition',[0.01 0.01 0.99 0.99]);

% legend(gca,'Location','best','Interpreter','none','FontSize',16);

f.Units = 'centimeters';

pos= f.Position;

f.PaperUnits = 'centimeters';

f.PaperSize = [pos(3)-pos(1), pos(4)-pos(2)];

saveas(f,f.Name,'pdf')

end