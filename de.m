rng default

fob = @(x) x(1).*sin(4*pi.*x(1)) - x(2).*sin(4*pi.*x(2) + pi) + 1;

lb = [-1 -1];       % limites inferiores
ub = [2 2];         % limites superiores

n = 100;            % numero de individuos
d = 2;              % numero de variaveis
cr = 0.9;           % taxa de cruzamento
F = 0.5;            
niter = 100;        % numero de iteracoes

% Inicializa a população e avalia cada individuo

x = zeros(n,d);
fitness = zeros(n,1);

for i=1:n
   
    x(i,:) = lb + (ub-lb).*rand(1,d);
    fitness(i) = fob(x(i,:));
    
end

% Encontra o atual melhor individuo

[fmax,index] = max(fitness);
best = x(index,:);

t=0;
conv = zeros(1,niter);

while t < niter

    t = t+1;
    
    conv(t) = fmax;
   
    for i=1:n
        
        % Mutacao
       
        % seleciona tres vetores aleatorios da populacao
        
        x1 = x(randi(n,1),:);   
        x2 = x(randi(n,1),:);   
        x3 = x(randi(n,1),:);
        
        % Calcula o Donor Vector
        
        v = x1 + F*(x2-x3);
        
        % Mantem o Donor Vector dentro dos limites
        
        for j=1:d
           
            if v(j) < lb(j)
               
                v(j) = lb(j);
                
            end
            
            if v(j) > ub(j)
               
                v(j) = ub(j);
                
            end
            
        end
        
        % Crossover
        
        % Testa a probabilidade de ocorrencia de cruzamento
        
        Kcr = rand(1,d) < cr;   
        
        % Calcula o Trial Vector
        
        u = x(i,:).*(1-Kcr) + v.*Kcr;
        
        % Selecao
        
        % Avalia o Trial Vector
        
        fnew = fob(u);  
        
        % Testa se o Trial Vector eh mais apto que o individuo
        
        if fnew > fob(x(i,:))
            
            x(i,:) = u;
            fitness(i) = fnew;
            
        end
        
    end
    
    % Atualiza o melhor individuo
    
    [fmax,index] = max(fitness);
    best = x(index,:);

    
end

% plot(conv)
% grid 
