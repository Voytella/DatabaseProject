#INSERT INTO table (id) VALUES (values);

# pairs [arg(id) arg(values)]
# lines of values is number of values
# value is provided by file
# id is name of column
# ARGS[1] is name of table

nameTab = ARGS[1];

# 
function getData()
    data = [];
    for ii in 2:2:length(ARGS)
        append!(data, (ARGS[ii], ARGS[ii+1]));
    end
    return data;
end

data = getData();
println(data);
