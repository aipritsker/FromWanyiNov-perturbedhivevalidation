        % treluga, 20120324.
% This code calculates the surface for honey collected based
% on the number of bees involved in collection, and stores
% it in a matrix that we can later use for interpolation.
% This will significantly speed up the model.

% x = stage(5)
% y = stage(6)

% The larger the numbers xn and yn, the more accurate your interpolation
% will be.
% Hn = 10; Fn = 10;
global hsurfX hsurfY hsurf;
% 
% % x and y are the ranges for stage(5) and stage(6).
% % The code has a problem if we plug 0 into the ODE's below, so we
% % start at 1.  I'm just guessing that 4000 is a large enough
% % upper bound, but this may need to be increased.
% H = linspace(10,10000,Hn); F = linspace(10,10000,Fn);
% hsurfX=H;
% hsurfY=F;
% hsurf = zeros(length(H),length(F));
% % for i=1:1:Hn
% % 	for j=1:1:Hn
% % 		Hi = H(i);
% % 		Fj = F(j);
% % 		predictedhoney = honeycollection( [0.8*H(i),0.8*H(i),1,0,0,0.8*F(j)]' );
% % 		hsurf(i,j) = predictedhoney;
% % 	end
% % end
% % 
% %  function ZI = honeystore(HB,FB)
%  global H F Z; 
gn=100;
H = linspace(1,500000,gn)';
F = linspace(1,500000,gn)';
I = [H,H,ones(gn,1),zeros(gn,1),zeros(gn,1),F]; 
hy=zeros(gn,1); 
for i=1:1:gn
       %initial(i,:)=I (i,:); 
      hy(i)= honeycollection(I(i,:));
end 
Z=repmat(hy, 1, gn);
hsurfX=H;
hsurfY=F;
hsurf=Z; 