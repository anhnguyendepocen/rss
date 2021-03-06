function [R, BR] = get_corr(m, Ne, cummap, Hpanel, cutoff, isgeno)
% USAGE: compute LD matrix using the shrinkage estimator in Wen and Stephens (2010)
% INPUT:
%	m: the number of individuals in the reference panel, integer
%	Ne: the effective population size (diploid), integer
%	cummap: cumulative genetic map in cM, numSNP by 1
%	Hpanel: the (phased) haplotypes from a reference panel, numIND by numSNP
%	cutoff: the hard threshold for small entries being zero, scalar 
%	isgeno: true if Hpanel is an unphased genotype matrix, logical
% OUTPUT:
%	R: the estimated LD matrix, numSNP by numSNP, sparse matrix
%	BR: the banded storage of R, dense matrix

  % decide whether Hpanel is haplotype or genotype
  if ~exist('isgeno', 'var')
    isgeno = false;
  end

  % compute the shrinkage estimator of covariance matrix
  disp('Compute Wen-Stephens shrinkage LD estimator ...'); 
  SigHat = shrink_cov(m, Ne, cummap, Hpanel, cutoff, isgeno);

  % convert covariance to correlation
  R = corrcov(SigHat);
  clear SigHat;

  if nargout > 1
    disp('Convert LD matrix to a banded storage ...');
 
    % get the bandwidth of R
    bwd = find_bandwidth(R);
  
    % get the banded storage of R
    BR = band_storage(R, bwd);
  end

  % store R as a sparse matrix
  R = sparse(R);
end

function SigHat = shrink_cov(m, Ne, cummap, Hpanel, cutoff, isgeno)
% USAGE: compute the shrinkage estimator of covariance matrix in Wen and Stephens (2010)
% INPUT:
%	m: number of individuals in a reference panel, integer
%	Ne: effective population size (diploid), integer
%	cummap: cumulative genetic map in cM, numSNP by 1
%	Hpanel: phased haplotypes or unphased genotypes in a reference panel, numIND by numSNP
%	cutoff: hard threshold for small entries being zero, scalar
%	isgeno: true if Hpanel is an unphased genotype matrix, logical 
% OUTPUT:
%	SigHat: estimated covariance matrix of haplotype, numSNP by numSNP

  % theta is related to mutation
  nmsum = sum(1 ./ (1:(2*m-1)));
  theta = (1/nmsum) / (2*m + 1/nmsum);
	
  % S is obtained from Sigma_panel by shrinking off-diagonal entries toward 0
  
  % Scenario 1: Hpanel is a phased haplotype matrix
  S = cov(Hpanel);

  % Scenario 2: Hpanel is an unphased genotype matrix
  if isgeno
    disp('Hpanel is an unphased genotype matrix.');
    S = 0.5*S;
  end

  S = triu(S);

  % compute the values on and above the 1st diagonal
  numSNP = size(S,1);
  for i = 1:numSNP
    for j = (i+1):numSNP
      if cummap(j) < cummap(i)
        error('Negative recombination rate is produced.')
      end
      rho = 4 * Ne * (cummap(j) - cummap(i)) / 100;
      shrinkage = exp(-rho/(2*m));
      % hard thresholding to obtain sparse and banded estimator
      if shrinkage < cutoff
        shrinkage = 0;
      end
      S(i, j) = shrinkage * S(i, j);
    end
  end

  % copy the upper half (NO diagonal) to the lower half
  S = S + triu(S, 1)';
	
  % SigHat is derived from Li and Stephens model (2003)
  SigHat = (1-theta)^2 * S + 0.5*theta * (1-0.5*theta) * eye(numSNP);
end

