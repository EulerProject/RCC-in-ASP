% This example w/ current encoding generates 82 PWs. 

%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent | sort -u | wc
%%       82    3874   41026

%% TO-DO: After adding parent coverage, we should get only 7 PWs .. 

% NOTE: When filtering on specific preds only, we get different |PWs| values!

%% DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=eq | sort -u | wc
%%       7      72     799
%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=po | sort -u | wc
%%       16      65     722
%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=dr | sort -u | wc
%%       16     128    1424
%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=pp | sort -u | wc
%%       21     200    2221
%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=ppi | sort -u | wc
%%       21     200    2421
%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=dr,pp | sort -u | wc
%%       64    1080   11944
%% [DLV :)]$ dlv rcc-asp.dlv input-2x2.dlv -silent -filter=dr,pp,po | sort -u | wc
%%       82    1528   16890

% INPUT TAP 

% T1
pp(b,a). pp(c,a).
dr(b,c).

% T2
pp("B","A"). pp("C","A").
dr("B","C").

% Articulations
eq(a,"A").

