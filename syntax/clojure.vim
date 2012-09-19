" Vim syntax file
" Language:    Clojure (http://clojure.org)
" Maintainer:  thinca <thinca+vim@gmail.com>
" License:     zlib License

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax case match
syntax sync fromstart

syntax match clojureError /]\|}\|)/

syntax cluster clojureAtoms contains=clojureError,clojureKeyword,clojureString,clojureCharacter,clojureBoolean,clojureNil,clojureQuote,clojureUnquote,clojureDispatch,clojureRegexp,clojureJavaNew,clojureJavaMethod,clojureAnonFnArgs
syntax cluster clojureTop contains=@clojureAtoms,clojureComment,clojureSexp,clojureAnonFn,clojureVector,clojureMap,clojureSet

" Constants
syntax keyword clojureBoolean true false
syntax keyword clojureNil nil

" Characters
syntax match clojureCharacter display /\\./
syntax match clojureCharacter display /\\o[0-7]\{1,3}\>/
syntax match clojureCharacter display /\\u[0-9a-zA-Z]\{4}\>/
syntax match clojureCharacter display /\\space\>/
syntax match clojureCharacter display /\\tab\>/
syntax match clojureCharacter display /\\newline\>/
syntax match clojureCharacter display /\\return\>/
syntax match clojureCharacter display /\\backspace\>/
syntax match clojureCharacter display /\\formfeed\>/

" Numbers
call clojure#syntax#define_numbers()

" String and Regexp
syntax region clojureString start=/"/  skip=/\\\\\|\\"/ end=/"/ contains=clojureStringSpecial
syntax region clojureRegexp start=/#"/ skip=/\\\\\|\\"/ end=/"/ keepend contains=clojureStringSpecial,clojureRegexpGroup,clojureRegexpClass,clojureRegexpCloseParenError
syntax match clojureStringSpecial display /\\./ contained
syntax region clojureRegexpGroup matchgroup=clojureParenLevelTop start=/(/ skip=/\\./ end=/)/ contained contains=clojureStringSpecial,clojureRegexpGroup,clojureRegexpClass,clojureRegexpOpenParenError
syntax region clojureRegexpClass matchgroup=clojureParenLevelTop start=/\[/ skip=/\\./ end=/\]/ contained transparent contains=clojureStringSpecial
syntax match clojureRegexpOpenParenError display /\\\@<!"/ contained
syntax match clojureRegexpCloseParenError display /)/ contained

" Keyword, etc
syntax match clojureKeyword display ":\{1,2}[[:alnum:]?!\-_+*.=<>#$/]\+"

syntax match clojureQuote display /['`]/
syntax match clojureUnquote display /\~@\?/
syntax match clojureDispatch display /#['^]/
syntax match clojureDispatch display /\^/
syntax match clojureAnonFnArgs display /%\d\+\>\|%&\?/ contained

" Java support
syntax match clojureJavaMethod display /\<\.[a-zA-Z_]\w*\>/
syntax match clojureJavaNew display /\<\u\w*\.\>/


call clojure#syntax#define_parens()

call clojure#syntax#define_keywords()

" Comments
syntax match clojureComment /;.*$/
syntax region clojureIgnoreFormComment matchgroup=clojureParenLevelComment start=/#_(/            end=/)/ contains=clojureRangeComment
syntax region clojureMacroComment      matchgroup=clojureParenLevelComment start=/(\_s*comment\>/ end=/)/ contains=clojureRangeComment
syntax region clojureRangeComment matchgroup=clojureParenLevelComment start=/(/  end=/)/  contains=clojureRangeComment contained
syntax region clojureRangeComment matchgroup=clojureParenLevelComment start=/\[/ end=/\]/ contains=clojureRangeComment contained
syntax region clojureRangeComment matchgroup=clojureParenLevelComment start=/{/  end=/}/  contains=clojureRangeComment contained
syntax cluster clojureTop add=clojureIgnoreFormComment,clojureMacroComment

highlight default link clojureIgnoreFormComment clojureComment
highlight default link clojureMacroComment      clojureComment
highlight default link clojureRangeComment      clojureComment
highlight default link clojureParenLevelComment clojureComment


" highlight
highlight default link clojureComment Comment

highlight default link clojureBoolean       Boolean
highlight default link clojureNil           Constant

highlight default link clojureString                String
highlight default link clojureStringSpecial         Special
highlight default link clojureRegexp                String
highlight default link clojureRegexpGroup           String
highlight default link clojureRegexpOpenParenError  Error
highlight default link clojureRegexpCloseParenError Error

highlight default link clojureKeyword   Operator
highlight default link clojureCharacter Character

highlight default link clojureJavaNew    Structure
highlight default link clojureJavaMethod Function

highlight default link clojureQuote    Special
highlight default link clojureUnquote  Special
highlight default link clojureDispatch Special

highlight default link clojureParenLevelTop Delimiter
highlight default link clojureAnonFnArgs Delimiter

highlight default link clojureError Error


let b:current_syntax = "clojure"

let &cpo = s:cpo_save
unlet s:cpo_save
