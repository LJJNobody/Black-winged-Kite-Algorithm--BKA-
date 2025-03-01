%________________________________________________________ ________________%
%  Black-winged Kite Algorithm (BKA) source codes                         %
%                                                                         %
%  Developed in MATLAB R2022b                                             %
%                                                                         %
%  Author and programmer:                                                 %
%  Black-winged Kite Algorithm: A nature-inspired meta-heuristic for
%              Solving benchmark functions and Engineering problems                                                                       %
%  e-Mail:                                                                %
%  Artificial Intelligence Review                                                                      %                                                                        %
%  DOI:                                                                   %
%                                                                         %
%_________________________________________________________________________%
%%

%%  Black-winged Kite Algorithm
function [eaPos,eaFit]=BKA(pop_size,T,lb,ub,dim,fobj)
%% ----------------Initialize the locations of Blue Sheep------------------%

p=0.9;r=rand;ea_size=pop_size;
XPos=initialization(pop_size,dim,lb,ub);% Initial population
XFit=fobj(XPos);
eaPos=[];eaFit=[];
[~,fronts]=fastNonDominatedSorting(XFit);
for i=fronts{1}
    eaPos=[eaPos;XPos(i,:)];
    eaFit=[eaFit;XFit(i,:)];
end

%% -------------------Start iteration------------------------------------%
for t=1:T
   
%% -------------------Attacking behavior-------------------%
    for i=1:pop_size
        
        n=0.05*exp(-2*(t/T)^2);
        if p<r
            XPosNew(i,:)=XPos(i,:)+n.*(1+sin(r))*XPos(i,:);
        else
            XPosNew(i,:)= XPos(i,:).*(n*(2*rand(1,dim)-1)+1);
        end
        XPosNew(i,:) = max(XPosNew(i,:),lb);XPosNew(i,:) = min(XPosNew(i,:),ub);%%Boundary checking
%% ------------ Select the optimal fitness value--------------%
        
        XFit_New(i,:)=fobj(XPosNew(i,:));
        if(Dominates(XFit_New(i,:),XFit(i,:)))
            XPos(i,:) = XPosNew(i,:);
            XFit(i,:) = XFit_New(i,:);
        end
%% -------------------Migration behavior-------------------%
 
        m=2*sin(r+pi/2);
        s = randi([1,30],1);
        ss=randi([1,size(eaPos,1)],1);
        r_XFitness=XFit(s,:);
        ori_value = rand(1,dim);cauchy_value = tan((ori_value-0.5)*pi);
        %if(Dominates(XFit(i,:),r_XFitness))
        if(Dominates(eaFit(ss,:),r_XFitness))
            XPosNew(i,:)=XPos(i,:)+cauchy_value(:,dim).* (XPos(i,:)-eaPos(ss,:));
        else
            XPosNew(i,:)=XPos(i,:)+cauchy_value(:,dim).* (eaPos(ss,:)-m.*XPos(i,:));
        end
        XPosNew(i,:) = max(XPosNew(i,:),lb);XPosNew(i,:) = min(XPosNew(i,:),ub); %%Boundary checking
%% --------------  Select the optimal fitness value---------%

        XFit_New(i,:)=fobj(XPosNew(i,:));
        if(Dominates(XFit_New(i,:),XFit(i,:)))
            XPos(i,:) = XPosNew(i,:);
            XFit(i,:) = XFit_New(i,:);
        end
    end
    %% -------Update the optimal Black-winged Kite----------%
    [~,fronts]=fastNonDominatedSorting(XFit);
    front1=fronts{1};
    for i=front1
        dominated=[];
        is_dominated=false;
        nEA=size(eaPos,1);
        for j=1:nEA
            if(Dominates(eaFit(j,:),XFit(i,:)))
                is_dominated=true;
                break;
            elseif(Dominates(XFit(i,:),eaFit(j,:)))
                dominated=[dominated,j];
            end
        end
        if(~is_dominated)
            eaPos(dominated,:)=[];
            eaFit(dominated,:)=[];
            %addToEA(XPos(i,:),XFit(i,:));
            if(size(eaPos,1)>=ea_size)
                crowding_distance=calculate_crowding_distance(eaFit);
                [~,index]=min(crowding_distance);
                eaPos(index,:)=[];
                eaFit(index,:)=[];
            end
            eaPos=[eaPos;XPos(i,:)];
            eaFit=[eaFit;XFit(i,:)];
        end
    end
end
end


