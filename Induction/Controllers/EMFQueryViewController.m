// EMFQueryViewController.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "EMFQueryViewController.h"

#import "EMFDatabaseViewController.h"
#import "EMFResultSetViewController.h"
#import "DBAdapter.h"

#import "NoodleLineNumberView.h"

@implementation EMFQueryViewController {
    __strong NoodleLineNumberView *_lineNumberView;
}

@synthesize databaseViewController = _databaseViewController;
@synthesize resultsTableViewController = _resultsTableViewController;
@synthesize contentBox = _contentBox;
@synthesize textView = _textView;
@synthesize lineNumberView = _lineNumberView;

- (void)awakeFromNib {
    self.textView.font = [NSFont userFixedPitchFontOfSize:18.0f];
    
    self.contentBox.contentView = self.resultsTableViewController.view;
    
    _lineNumberView = [[NoodleLineNumberView alloc] initWithScrollView:[self.textView enclosingScrollView]];
    _lineNumberView.backgroundColor = [NSColor whiteColor];
    [[self.textView enclosingScrollView] setVerticalRulerView:_lineNumberView];
    [[self.textView enclosingScrollView] setHasHorizontalRuler:NO];
    [[self.textView enclosingScrollView] setHasVerticalRuler:YES];
    [[self.textView enclosingScrollView] setRulersVisible:YES];	
}

#pragma mark - IBAction

- (IBAction)execute:(id)sender {
    [(id <DBQueryableDataSource>)self.representedObject fetchResultSetForQuery:[self.textView string] success:^(id<DBResultSet> resultSet, NSTimeInterval elapsedTime) {
        self.resultsTableViewController.representedObject = resultSet;
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
