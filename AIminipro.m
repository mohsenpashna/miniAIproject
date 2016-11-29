% AI mini project

% fitness function f(x) = 3x^2+ 4x + 6
clear,cl
x=-10:.01:10;

y= AIftfunc(x);

figure(1), plot(x,y)

Nchrm = 80; % Number of Chromosomes (Individuals)
MxItr = 20;% Number of Maximume Iterations
MrgProb = 80;% Probeilty of Marrage between chromosomes
MutProb = 30;% Probeilty of Mutation between chromosomes
itr = 1;


% Initially setup chromosomes
hold on
for cntr = 1:Nchrm
    Chromosome(itr,cntr).bin = Chromo(ceil(20*rand(1)));
    u = bin2dec(Chromosome(itr,cntr).bin)/51.15-10;
    v = AIftfunc(u);
    plot(u,v,'g*')
end
% nGen(1,1) =[];nGen(2,1) =[];
while itr <= MxItr
%     Fitness Table
    for cntr = 1:Nchrm
        FT(itr,cntr) = AIfitness(Chromosome(itr,cntr).bin);
    end
    
%     Mating Pool
    MtNu = 2*floor(MrgProb*Nchrm/200);
    selChrom = randgrab(MtNu,Nchrm);
    PairNu = length(selChrom)/2;
    for cntr = 1: PairNu
        [nGen(cntr,:),nGen(PairNu+cntr,:)] = AImelt(Chromosome(2*cntr-1).bin,Chromosome(2*cntr).bin);
    end
    
    clear Population
    Population = nGen;
    for cntr = 1: Nchrm
        Population(cntr + 2*PairNu,:) = Chromosome(itr,cntr).bin;
    end

    for cntr = 1:size(Population,1)
        PupFit(cntr) = AIfitness(Population(cntr,:));
    end
    A=sort(PupFit);
    ofidx=find(PupFit<=A(Nchrm),Nchrm,'first');% selected off-springs index
%     offsprings = Population(ofidx,:);

    hold off,plot(x,y),hold on
    for cntr = 1:Nchrm
        Chromosome(itr+1,cntr).bin =  Population(ofidx(cntr),:);
%         u = bin2dec(Chromosome(itr+1,cntr).bin)/51.15-10;
%         v = 3*u.^2+4*u+6;
%         plot(u,v,'g*'),title(itr)
    end
    
        
%     Applying Mutation

    if rand(1) <= MutProb /100
        MuRnd = ceil(rand*Nchrm);
        btRnd = ceil(10*rand(1));
        switch Chromosome(itr+1,MuRnd).bin(btRnd)
            case '0'
                Chromosome(itr+1,MuRnd).bin(btRnd) = '1';
            case '1'
                Chromosome(itr+1,MuRnd).bin(btRnd) = '0';
        end
    end
 
    
    for cntr = 1:Nchrm
        u = bin2dec(Chromosome(itr+1,cntr).bin)/51.15-10;
        v = AIftfunc(u);
        plot(u,v,'g*'),title(itr)
    end
    
    pause(.2)
    itr = itr + 1;
end



