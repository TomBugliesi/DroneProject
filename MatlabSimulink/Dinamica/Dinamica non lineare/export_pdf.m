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

f.OuterPosition = [0 0 0.5 0.5];

f.Units = 'centimeters';

pos= f.Position;

f.PaperUnits = 'centimeters';

f.PaperSize = [pos(3)-pos(1), pos(4)-pos(2)+0.3];

saveas(f,f.Name,'pdf')

end