/* --- std::map --- */
%warnfilter(302) Struct;
%include "std_map.i"

// for valueAverage & stringifyKeys
%apply(std::map INPUT)               { std::map m };

// for populate
%apply(std::map &OUTPUT)             { std::map &m };

%include "li_std_map.i"
