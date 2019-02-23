% n*d�s�� D_pos, D_neg�ɂ��ꂼ��C
% d������n���̉摜����(���K������Ă��Ȃ�)BoF�x�N�g���������Ă���Ƃ��܂��D
tic;
cv=5;
idx1=[1:200];
pcount=zeros(2,5); % ����
ncount=zeros(2,5); % �s����
for a=1:2
    if a==1
        load('cat_dog_bovw2.mat','code');
        bovw2=code';
    else
        load('dog_wolf_bovw2.mat','code');
        bovw2=code';
    end
    D_pos = bovw2(1:200,:);
    D_neg = bovw2(201:400,:);
    for b = 1:cv  
        % positive �摜�̏o���m��(��log�̒l��)�e�[�u�����쐬
        pr_pos = sum(D_pos(find(mod(idx1,cv)~=(b-1)),:)) + 1;
        pr_pos = pr_pos/sum(pr_pos);
        pr_pos = log(pr_pos);
        
        % negative �摜�̏o���m��(��log�̒l��)�e�[�u�����쐬
        pr_neg = sum(D_neg(find(mod(idx1,cv)~=(b-1)),:)) + 1;
        pr_neg = pr_neg/sum(pr_neg);
        pr_neg = log(pr_neg);
        
        for t=find(mod(idx1,cv)==(b-1)) %�|�W�e�B�u�摜�̕���
            im=D_pos(t,:);
            
            max0=max(im);
            idx=[];
            for i=1:max0
                idx=[idx find(im>=i)];
            end
            % positive, negative ���� �P��̏o���m���l��log�̘a���v�Z
            pr_im_pos=sum(pr_pos(idx));
            pr_im_neg=sum(pr_neg(idx));
            
            % �|�W�e�B�u�ɂȂ�ΐ���
            if pr_im_pos>pr_im_neg
                pcount(a,b)=pcount(a,b)+1;
            else
                ncount(a,b)=ncount(a,b)+1;
            end
        end
        
        for t=find(mod(idx1,cv)==(b-1)) %�l�K�e�B�u�摜�̕���
            im=D_neg(t,:);
            
            max0=max(im);
            idx=[];
            for i=1:max0
                idx=[idx find(im>=i)];
            end
            pr_im_pos=sum(pr_pos(idx));
            pr_im_neg=sum(pr_neg(idx));
            % positive, negative ���� �P��̏o���m���l��log�̘a���v�Z
            
            % �l�K�e�B�u�ɂȂ�ΐ���
            if pr_im_neg>pr_im_pos
                pcount(a,b)=pcount(a,b)+1;
            else
                ncount(a,b)=ncount(a,b)+1;
            end
        end
        r(a,b)=pcount(a,b)/(pcount(a,b)+ncount(a,b));
    end
end

fprintf('猫と犬の分類率: %.4f\n',mean(r(1,:)))
fprintf('犬とオオカミの分類率: %.4f\n',mean(r(2,:)))
toc;