clear, cl

% Search Range Definition
% ===============================
% The range is x=[Rn,Rx]

Rn =-2; Rx = 6;

x=Rn:.01:Rx;
X= x - Rn;
CrrFx = (1023/max(X));
X = CrrFx * X;
y= AIftfunc(x);
figure(1), plot(x,y)


Nchrm = 50; % Number of Chromosomes (Individuals)
MxItr = 20;% Number of Maximume Iterations
MrgProb = 100;% Probeilty of Marrage between chromosomes
MutProb = 50;% Probeilty of Mutation between chromosomes


itr = 1;
% Initial chromosomes
hold on
for cntr = 1:Nchrm
    Chromosome(itr,cntr).bin = Chromo(ceil(20*rand(1)));
    u = bin2dec(Chromosome(itr,cntr).bin)/CrrFx+Rn;
    v = AIftfunc(u);
    plot(u,v,'g*')
end




while itr <= MxItr
%     Fitness Table
    for cntr = 1:Nchrm
        FT(itr,cntr) = AIfitness(Chromosome(itr,cntr).bin,CrrFx,Rn);
    end
       
% =======================================       
%     Mating Pool
% =======================================

    MtNu = 2*floor(MrgProb*Nchrm/200);
%     selChrom = randgrab(MtNu,Nchrm);
    selChrom = roulette(FT(itr,:),Nchrm, 'min');
    PairNu = length(selChrom)/2;
    
    
% =======================================    
%     Recombination (Cross Over)
% =======================================
    for cntr = 1: PairNu
        [nGen(cntr,:),nGen(PairNu+cntr,:)] = AIcrossover(Chromosome(2*cntr-1).bin,Chromosome(2*cntr).bin);
    end
    
    clear Population
    Population = nGen;
    for cntr = 1: Nchrm
        Population(cntr + 2*PairNu,:) = Chromosome(itr,cntr).bin;
    end
    
% =======================================    
%     Mutation
% =======================================   
    if rand(1) <= MutProb /100
        MuRnd = ceil(rand*Nchrm);
        btRnd = ceil(10*rand(1));
        switch Population(MuRnd,btRnd)
            case '0'
                Population(MuRnd,btRnd) = '1';
            case '1'
                Population(MuRnd,btRnd) = '0';
        end
    end
 
% =======================================    
%     Selection
% =======================================    
    for cntr = 1:size(Population,1)
        PupFit(cntr) = AIfitness(Population(cntr,:),CrrFx,Rn);
    end
    A=sort(PupFit);
    ofidx=find(PupFit<=A(Nchrm),Nchrm,'first');% selected off-springs index
    for cntr = 1:Nchrm
        Chromosome(itr+1,cntr).bin =  Population(ofidx(cntr),:);
    end
    
    
    hold off,plot(x,y),hold on
    for cntr = 1:Nchrm
        u = bin2dec(Chromosome(itr+1,cntr).bin)/CrrFx+Rn;
        v = AIftfunc(u);
        plot(u,v,'g*'),title(itr)
    end
    
    pause(.2)
    itr = itr + 1;
end











