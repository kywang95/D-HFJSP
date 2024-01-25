function [ Cost ] = COST(SS0, data)
% function [ CompleTnonTran, CompleTranB2A, CompleTranA2B] = COST(SS, data)
%{
Step 1: calculating the completion time of operation 1.
Step 2: for specimens processed in factory B, follow the assignment
rule to decide it being processed in factory B or transferred to
factory A for the rest of the operations.
Assignment rule: batch specimens in factory A to make the machines in
factory A for opearation 3 work at full capacity. For specimens assigned to
factory B, divide the specimens of the same type into bunches according to
the completion time of operation 1. For every bunch in factory B, batch
the specimens according to the capacity of the machines in operation 3.
Choose the last batch of specimens at the end of every bunch, transfer it
into factory A and get a new workflow of factory A and B. Do the following
steps for the new workflow.
Step 3: for the rest of the operations, batch the specimens according to
the capacity of the machines. For every batch, get the completion time of
the last operation. Get the starting time of current operation based on
the completion time of the last operation, the capacity of the first
available machine.
%}
if nargin == 2
    transport = 'None';
end
Type0 = data.Specimen(2,:);
c = data.c;
m = data.m;
t0 = data.t;
% DD0 = data.DD;
% tran = data.tran;

Type = Type0(SS0);
t = t0(SS0,:,:);
% DD = DD0(SS0);
SS = 1:length(SS0);
%% operation 1 -- centrifugation
N = length(SS);
Cs1 = zeros(1,N);
SS1 = SS;
MA1 = zeros(1,N);
% the property of machines for operation 1
% The two rows of C1 are the avaliable time of each machine,
% the factory index the machine belongs to.
[cap1,I] = sort(c{1},'descend');
C1 = [zeros(1,m{1}(I(1))) zeros(1,m{1}(I(2))); ones(1,m{1}(1))*I(1) ones(1,m{1}(2))*I(2)];
t1(:,1) = t(:,1,1);
t1(:,2) = t(:,1,2);
s = 1;
while s <= N
    p2 = min(C1(1,:));
    q2 = find(C1(1,:) == p2);
    if (N-s+1) <= cap1(2)
        q2 = q2(end);
    else
        q2 = q2(1);
    end
    if cap1(C1(2,q2)) < (N-s+1)
        processT = max(t1(SS( s:(s+cap1(C1(2,q2))-1)), C1(2,q2)));
        Cs1(SS(s:(s+cap1(C1(2,q2))-1))) = (processT + p2) * ones(1,cap1(C1(2,q2)));
        C1(1,q2) = processT + p2;
        MA1(s:(s+cap1(C1(2,q2))-1)) = C1(2,q2) * ones(1,cap1(C1(2,q2)));
        s = s + cap1(C1(2,q2));
    else
        processT = max(t1(SS(s:N),C1(2,q2)));
        Cs1(SS(s:N)) = (processT + p2) * ones(1,(N-s+1));
        C1(1,q2) = processT + p2;
        MA1(s:N) = C1(2,q2) * ones(1,(N-s+1));
        s = N + 1;
    end
end
% Cs1
% SS1
% MA1

%% machine 2 & machine 3
[Cs1,index] = sort(Cs1,'ascend');
SS1 = SS1(index);
MAB = MA1(index);

% %% adjsted MAA
% % for every interval in factory B, if the completion time in factory A
% % dosen't reach the upper bound, transport the last (CapB-CapB\bunchB)
% % specimens in factory B to factory A. Get the machine assignment vector
% % after transportation as MAA, the vector before transportation as MAB.
% CsB2A = Cs1;
% CsB2A(MA1==2) = Cs1(MA1==2) + tran;
% SSB = SS1(MA1==2);
% CsB = CsB2A(MA1==2);
% MAA = MA1;
% IB = [find(diff(CsB)~=0) length(CsB)];
% % capacity -- c{3}(j,k): factory j, Type k specimens
% % cap3 = c{3}; 
% % a=1, chemistry; a=2, immunoassay
% for a = 1:2 
%     cap3B = c{3}(2,a);
%     SSa = SS1(Type(SS1)==a);
%     MAa = MA1(Type(SS1)==a);
%     Csa = CsB2A(Type(SS1)==a);
%     SSaB = SSa(MAa==2);
%     CsaB = Csa(MAa==2);
%     IaB = [0 find(diff(CsaB)~=0) length(CsaB)];
%     for ia = 2:length(IaB)
%         interB = length(CsaB((IaB(ia-1)+1):IaB(ia)));
%         revB = mod(interB,cap3B);
%         if (revB==0) && (interB>=cap3B)
%             revB = cap3B;
%         end
%         % set the index of revB in MAA as 1
%         maB2A = SSaB((IaB(ia)-revB+1):IaB(ia));
%         for r = 1:revB
%             MAA(SS1 == maB2A(r)) = 1;
%         end
%     end
% end
% 
% %% adjsted MAC
% % for every interval in factory A, if the completion time in factory B
% % dosen't reach the upper bound, transport the last (CapA-CapA\bunchA)
% % specimens in factory A to factory B. Get the machine assignment vector
% % after transportation as MAC, the vector before transportation as MAB.
% CsA2B = Cs1;
% CsA2B(MA1==1) = Cs1(MA1==1) + tran;
% SSA = SS1(MA1==1);
% CsA = CsA2B(MA1==1);
% MAC = MA1;
% IA = [find(diff(CsA)~=0) length(CsA)];
%  % capacity -- c{3}(j,k): factory j, Type k specimens
%  cap3 = c{3};
%  % a=1, chemistry; a=2, immunoassay
%  for b = 1:2
%     cap3A = c{3}(1,b);
%     SSb = SS1(Type(SS1)==b);
%     MAb = MA1(Type(SS1)==b);
%     Csb = CsA2B(Type(SS1)==b);
%     SSbA = SSb(MAb==1);
%     CsbA = Csb(MAb==1);
%     IbA = [0 find(diff(CsbA)~=0) length(CsbA)];
%     for ib = 2:length(IbA)
%         interA = length(CsbA((IbA(ib-1)+1):IbA(ib)));
%         revA = mod(interA,cap3A);
%         if (revA==0) && (interA>=cap3A)
%             revA = cap3A;
%         end
%         % set the index of revA in MAC as 2
%         maA2B = SSbA((IbA(ib)-revA+1):IbA(ib));
%         for r = 1:revA
%             MAC(SS1 == maA2B(r)) = 2;
%         end
%     end
% end
% % MAA
% % MAB
% % MAC
% 
% %  while find(MA2==0)
% % function(ic) MAA(ic) = ones(size(MA1(%ic)));
% 
% % Assign the Rountine, whether to transfer specimens to factory A or
% % examine them in factory B
% StarT2 = Cs1;
%% Completion time of operation 2 -- decapper
% Rountine B-->B(without transportation) or Rountine B-->A(with transportation)
for i = 1:2
switch transport
    % without transportation
    case 'None'
        MA = MAB;
        StarT2 = Cs1;
        % Rountine B-->A
    case 'Transport_to_A'
        MA = MAA;
        StarT2 = CsB2A;
        % Rountine A-->B
    case 'Transport_to_B'
        MA = MAC;
        StarT2 = CsA2B;
end
    % the property of machines for operation 2
    % The two rows of C2 are the avaliable time of each machine,
    % the factory index the machine belongs to.
    
    % factory A: CA2 = zeros(1,m{2}(1)); SSA = SS1(MA==1); CsA = Cs1(MA==1);
    % factory B: CB2 = zeros(1,m{2}(2)); SSB = SS1(MA==2); CsB = Cs1(MA==2); % factory A
    %     Cs2 = StarT2;
    %     Cs3 = Cs2;
    %     Cs4 = Cs2;
    for j =1:2 % factory A or B
        clear SS;
        clear Cs;
        C2 = zeros(1,m{2}(j));
        cap2 = c{2}(j);
        t2 = t(:,2,j);
        SS = SS1(MA==j);
        Cs = StarT2(MA==j);
        N = length(SS); s = 1; Com2 = Cs;
        while s <= N
            [p1,q1] = min(C2);
            %                 p1 = p1(1);
            %                 q1 = q1(1);
            if cap2 < (N-s+1)
                processT = max(t2(SS(s:(s+cap2-1))));
                Com2(s:(s+cap2-1)) = (max(max(Cs(s:(s+cap2-1))),p1) + processT) * ones(1,cap2);
                %                     Cs2(SS(s:(s+cap2-1))) = Com2(s:(s+cap2-1));
                C2(1,q1) = max(max(Cs(s:(s+cap2-1))),p1) + processT;
                s = s + cap2;
            else
                processT = max(t2(SS(s:N)));
                Com2(s:N) = (max(max(Cs(s:N)),p1) + processT) * ones(1,(N-s+1));
                %                     Cs2(SS(s:N)) = Com2(s:N);
                C2(1,q1) = max(max(Cs(s:N)),p1) + processT;
                s = N+1;
            end
        end
        
        %% Completion time of operation 3 -- analysis of chemistry and immunoassay
        % the property of machines for operation 3
        % size(C3,2) = length(machine for type 1 or for type 2 specimens )
        % C3 represents the avaliable time of each machine in factory j
        % for type k specimens
        [Com2,index] = sort(Com2,'ascend');
        SS = SS(index);
        for k = 1:2 % the type of specimens, k = 1, chemistry; k = 2, immunoassay
            C3 = zeros(1,m{3}(j,k));
            cap3 = c{3}(j,k);
            %                 t3 = t{3}(j,k);
            t3 = t(:,3,j);
            SSk = SS(Type(SS)==k);
            Csk = Com2(Type(SS)==k);
            s = 1;
            N = length(SSk);
            Com3 = Csk;
            while s <= N
                [p3,q3] = min(C3);
                %                     p3 = p3(1);
                %                     q3 = q3(1);
                if cap3 < (N-s+1)
                    processT = max(t3(SSk(s:(s+cap3-1))));
                    Com3(s:(s+cap3-1)) = (max(max(Csk(s:(s+cap3-1))),p3)+processT) * ones(1,cap3);
                    %                         Cs3(SSk(s:(s+cap3-1))) = Com3(s:(s+cap3-1));
                    C3(1,q3) = max(max(Csk(s:(s+cap3-1))),p3)+processT;
                    s = s + cap3;
                else
                    processT = max(t3(SSk(s:N)));
                    Com3(s:N) = (max(max(Csk(s:N)),p3)+processT) * ones(1,(N-s+1));
                    %                         Cs3(SSk(s:N)) = Com3(s:N);
                    C3(1,q3) = max(max(Csk(s:N)),p3) + processT;
                    s = N+1;
                end
            end
            %               Com3
            if j==1 % factory A
                if k == 1 % chemistry specimens
                    Com3AC = Com3;
                    SS3AC = SSk;
                elseif k == 2 % immunoassay specimens
                    Com3AI = Com3;
                    SS3AI = SSk;
                end
            elseif j==2 % factory B
                if k == 1 % chemistry specimens
                    Com3BC = Com3;
                    SS3BC = SSk;
                elseif k == 2 % immunoassay specimens
                    Com3BI = Com3;
                    SS3BI = SSk;
                end
            end
        end
        
        %             %% adjsted MA2
        %             % Evaluate the completion time of the two situations. If the total
        %             % completion time in factory A for all the specimens before the batch
        %             % (include the batch itself) are larger than that in factory B,
        %             % set the batch tested in factory B, vice versa.
        %             % update the vector MAA, MAB and MA2
        %             MA2 = MA1;
        
        %% Operation 4 ?? check and issue
        clear SS3;
        if j == 1
            CsA3 = [Com3AC Com3AI];
            SSA3 = [SS3AC SS3AI];
            
            [CsA3,index] = sort(CsA3,'ascend');
            SSA3 = SSA3(index);
            
            StarT3 = CsA3;
            SS3 = SSA3;
        elseif j == 2
            CsB3 = [Com3BC Com3BI];
            SSB3 = [SS3BC SS3BI];
            [CsB3,index] = sort(CsB3,'ascend');
            SSB3 = SSB3(index);
            StarT3 = CsB3;
            SS3 = SSB3;
        end
        C4 = zeros(1,m{4}(j));
        cap4 = c{4}(j);
        %             t4 = t{4}(j);
        t4 = t(:,4,j);
        s = 1;
        N = length(SS3);
        Com4 = StarT3;
        while s <= N
            [p4,q4] = min(C4);
            %                 p4 = p4(1);
            %                 q4 = q4(1);
            if cap4 < (N-s+1)
                processT = max(t4(SS3(s:(s+cap4-1))));
                Com4(s:(s+cap4-1)) = (max(max(StarT3(s:(s+cap4-1))),p4)+processT) * ones(1,cap4);
%                 Cs4(SS3(s:(s+cap4-1))) = Com4(s:(s+cap4-1));
                C4(1,q4) = max(max(StarT3(s:(s+cap4-1))),p4) + processT;
                s = s + cap4;
            else
                processT = max(t4(SS3(s:N)));
                Com4(s:N) = (max(max(StarT3(s:N)),p4)+processT) * ones(1,(N-s+1));
%                 Cs4(SS3(s:N)) = Com4(s:N);
                C4(1,q4) = max(max(StarT3(s:N)),p4) + processT;
                s = N+1;
            end
        end
        if  j == 1
            CsA4 = Com4;
        elseif j == 2
            CsB4 = Com4;
        end
    end
    SSCom = [SSA3 SSB3];
    Cs4 = [CsA4 CsB4];
    CompleT(1, SSCom) = Cs4;
    if strcmp(transport, 'None')
        break
    else
        CompleT(2, :) = CompleT(1, :);
    end
    switch transport
        case {'Transport_to_A', 'Transport_to_B'}
        transport = 'None';
    end
end
%     CompleTnonTran
%     CompleTranB2A
%     CompleTranA2B
% for i = 1:size(CompleT,1)
%     TATO = CompleT(i,:) - DD';
%     outlier(i) = length(TATO(TATO>0));
%     eTATO(i) = outlier(i)/length(TATO);
% end
% TATOP = min(eTATO);
Cost = min(mean(CompleT,2));
end
