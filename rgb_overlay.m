function rgb_overlay = rgb_overlay(labelled_img_stack, original_img_stack)
  % Make colors more beautiful by setting an upper limit on the label values,
  % where labels larger than the limit won't display color differences.
  COLOR_LIMIT = prctile(unique(labelled_img_stack,98);
  labelled_img_stack(labelled_img_stack>COLOR_LIMIT)=COLOR_LIMIT; % make colors more beautiful by putting an upper limit
  
  boundries_rgb = zeros(size(original_img_stack, 1), size(original_img_stack, 2), size(original_img_stack, 3), 3);
  for i = 1:size(original_img_stack, 3)
    % set on each slice the minimum and maximum color to be the same
    labelled_img_stack_color_fix=labelled_img_stack(:,:,i);
    labelled_img_stack_color_fix(1)=min(labelled_img_stack(labelled_img_stack>0)); % smallest non-zero value
    labelled_img_stack_color_fix(2)=COLOR_LIMIT;
    boundries_rgb(:,:,i,:) = label2rgb(round(labelled_img_stack_color_fix),'jet', 'k');
  end
  original_img_stack_rgb = cat(4, original_img_stack, original_img_stack, original_img_stack);
  BRIGHTNESS_FACTOR = 6; % control how bright the rgb segmented boundries will be
  rgb_overlay = uint8(boundries_rgb./BRIGHTNESS_FACTOR) ... % segmented boundries
               + uint8(original_img_stack_rgb);           % original original_img_stack
  
  figure('name','rgb_overlay', 'NumberTitle','off');imshow3Dfull(uint8(rgb_overlay),[]);
end