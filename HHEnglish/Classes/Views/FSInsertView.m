//
//  FSInsertView.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSInsertView.h"
#import "UITextView+Placeholder.h"

@interface FSInsertView ()<UITextViewDelegate>

@property (nonatomic, weak) UILabel *label;

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, strong) NSLayoutConstraint *textViewBottomConstraint;

@property (nonatomic, strong) NSLayoutConstraint *textViewTopConstraint;

@end

static NSString * const kTextViewBoundsKey = @"bounds";

@implementation FSInsertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)setupSubviews
{
    UILabel *label = [[UILabel alloc] init];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.label = label;
    
    label.font = [UIFont systemFontOfSize:14];
    
    label.textColor = [UIColor darkTextColor];
    
    [self addSubview:label];
    
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.scrollEnabled = NO;
    
    textView.delegate = self;
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textView = textView;
    
    textView.layer.borderColor = [UIColor redColor].CGColor;
    
    textView.layer.borderWidth = 0.5;
    
    textView.layer.cornerRadius = 3;
    
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.textColor = [UIColor darkTextColor];
    
    [self addSubview:textView];
    
    [textView addObserver:self
               forKeyPath:kTextViewBoundsKey
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    
    [label.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active = YES;
    [label.widthAnchor constraintEqualToConstant:60].active = YES;
    [label.heightAnchor constraintEqualToConstant:30].active = YES;
    [label.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    
    [textView.leftAnchor constraintEqualToAnchor:label.rightAnchor constant:5].active = YES;
    [textView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10].active = YES;
    self.textViewTopConstraint = [textView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8];
    self.textViewTopConstraint.active = YES;
    self.textViewBottomConstraint = [textView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8];
    self.textViewBottomConstraint.active = YES;
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.scrollEnabled)
    {
        CGPoint point = CGPointMake(0, textView.contentSize.height - textView.bounds.size.height);
        
        if (textView.contentOffset.y != point.y)
        {
            [self.textView setContentOffset:point animated:YES];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kTextViewBoundsKey])
    {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue].size;
        
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue].size;
        
        if (oldSize.height < newSize.height)
        {
            CGFloat tvTopSpace = fabs(self.textViewTopConstraint.constant);
            
            CGFloat tvBottomSpace = fabs(self.textViewBottomConstraint.constant);
            
            CGFloat maxValue = self.maxHeightLayoutConstraint.constant - tvTopSpace - tvBottomSpace;
            
            if (newSize.height == maxValue && !self.textView.scrollEnabled)
            {
                self.textView.scrollEnabled = YES;
                
                CGPoint point = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);
                
                [self.textView setContentOffset:point animated:YES];
            }
        }
        else if (oldSize.height > newSize.height)
        {
            if (self.textView.scrollEnabled)
            {
                self.textView.scrollEnabled = NO;
                
                [self.textView setNeedsUpdateConstraints];
            }
        }
        else
        {
            CGSize contentSize = self.textView.contentSize;
            
            if (contentSize.height < newSize.height)
            {
                if (self.textView.scrollEnabled)
                {
                    self.textView.scrollEnabled = NO;
                    
                    [self.textView setNeedsUpdateConstraints];
                }
            }
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview)
    {
        NSLayoutConstraint *leftLayoutConstraint = [self.leftAnchor constraintEqualToAnchor:newSuperview.leftAnchor];
        _leftLayoutConstraint = leftLayoutConstraint;

        NSLayoutConstraint *rightLayoutConstraint = [self.rightAnchor constraintEqualToAnchor:newSuperview.rightAnchor];
        _rightLayoutConstraint = rightLayoutConstraint;

        NSLayoutConstraint *bottomLayoutConstraint = [self.bottomAnchor constraintEqualToAnchor:newSuperview.bottomAnchor];
        _bottomLayoutConstraint = bottomLayoutConstraint;


        NSLayoutConstraint *minHeightLayoutConstraint = [self.heightAnchor constraintGreaterThanOrEqualToConstant:52];
        _minHeightLayoutConstraint = minHeightLayoutConstraint;

        NSLayoutConstraint *maxHeightLayoutConstraint = [self.heightAnchor constraintLessThanOrEqualToConstant:119];
        _maxHeightLayoutConstraint = maxHeightLayoutConstraint;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = _title;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    
    [attr setObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
    
    [attr setObject:self.textView.font forKey:NSFontAttributeName];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_placeholder attributes:attr];
    
    self.textView.attributedPlaceholder = attrString;
}

- (NSString *)text
{
    return self.textView.text;
}

- (void)setText:(NSString *)text
{
    self.textView.text = text;
}


@end
