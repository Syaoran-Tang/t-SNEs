for i = 1:size(X_tsne(:,1))
	if X_tsne(i,1) > 0 && X_tsne(i,2) > 0
		r = sqrt(X_tsne(i,1).^2 + X_tsne(i,2).^2);
		a = atan(X_tsne(i,2)./X_tsne(i,1));
		X_tsne(i,1) = r;
		X_tsne(i,2) = a;
	elseif X_tsne(i,1) < 0 && X_tsne(i,2) > 0
		r = sqrt(X_tsne(i,1).^2 + X_tsne(i,2).^2);
		a = pi/2 + atan(X_tsne(i,2)./-X_tsne(i,1));
		X_tsne(i,1) = r;
		X_tsne(i,2) = a;
	elseif X_tsne(i,1) < 0 && X_tsne(i,2) < 0
		r = sqrt(X_tsne(i,1).^2 + X_tsne(i,2).^2);
		a = pi + atan(X_tsne(i,2)./-X_tsne(i,1));
		X_tsne(i,1) = r;
		X_tsne(i,2) = a;
	elseif X_tsne(i,1) > 0 && X_tsne(i,2) < 0
		r = sqrt(X_tsne(i,1).^2 + X_tsne(i,2).^2);
		a = pi*3/2 + atan(X_tsne(i,2)./-X_tsne(i,1));
		X_tsne(i,1) = r;
		X_tsne(i,2) = a;
	elseif X_tsne(i,1) == 0 && X_tsne(i,2) > 0
		X_tsne(i,1) = X_tsne(i,2);
		X_tsne(i,2) = pi/2;
	elseif X_tsne(i,1) == 0 && X_tsne(i,2) < 0
		X_tsne(i,1) = -X_tsne(i,2);
		X_tsne(i,2) = pi*3/2;
	elseif X_tsne(i,1) > 0 && X_tsne(i,2) == 0
		X_tsne(i,2) = 0;
	elseif X_tsne(i,1) < 0 && X_tsne(i,2) == 0
		X_tsne(i,1) = -X_tsne(i,1);
		X_tsne(i,2) = pi;
	end
end

for i = 1:size(X_tsne(:,1))
	in_angle = mod(X_tsne(i,2), pi/2);
	if in_angle ~= 0
		if in_angle < pi/4
			X_tsne(i,1) = X_tsne(i,1)*pi/((pi/sqrt(2))/cos(in_angle));
		elseif in_angle > pi/4
			X_tsne(i,1) = X_tsne(i,1)*pi/((pi/sqrt(2))/cos(pi/2 - in_angle));
		end
	else
		X_tsne(i,1) = X_tsne(i,1) * sqrt(2);
	end
end

x = bsxfun(@times,sin(X_tsne(:,1)),cos(X_tsne(:,2)));
y = bsxfun(@times,sin(X_tsne(:,1)),sin(X_tsne(:,2)));
z = cos(X_tsne(:,1));
scatter3(x, y, z, 30, label, 'filled');
axis([-1.1, 1.1, -1.1, 1.1, -1.1, 1.1]);