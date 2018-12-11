clear;clc;clf

rng default
run ga.m
conv_ga = conv;

rng default
run de.m
conv_de = conv;

plot(conv_ga,'LineWidth',2)
hold
plot(conv_de,'LineWidth',2)

grid on
title('Evolucao da Converg�ncia')
xlabel('Itera��es')
ylabel('Aptid�o')
legend('AG','ED','Location','southeast')