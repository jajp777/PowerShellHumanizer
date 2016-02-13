﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.ps1', '.psd1'
ipmo "$here\$sut" -Force

Describe 'Functions' {
    Context 'Pluralize' {
        It 'Should convert man to men' {
            ConvertTo-Plural man | Should Be 'men'
        }
        It 'Should convert an array' {
            $output = echo person man woman | ConvertTo-Plural
            $output[0] | Should Be 'people'
            $output[1] | Should Be 'men'
            $output[2] | Should Be 'women'
        }
    }
    Context 'Singularize' {
        $output = echo people men women geese indicies oxen knives | ConvertTo-Singular
        It 'Should convert to singles' {
            $output[0] | Should Be 'person'
            $output[1] | Should Be 'man'
            $output[2] | Should Be 'woman'
            $output[3] | Should Be 'goose'
            $output[4] | Should Be 'indicy'
            $output[5] | Should Be 'ox'
            $output[6] | Should Be 'knife'
        }

    }
    Context 'Hyphenate' {
        It 'Should convert to a hyphenated string' {
            "Continuing To Make Powershell A Bit More Human" | ConvertTo-HyphenatedString | Should Be 'continuing-to-make-powershell-a-bit-more-human'
        }

    }
    Context 'Number to ordinal words' {
        It 'Should convert to words' {
            ConvertTo-OrdinalWords 121 | Should Be 'hundred and twenty first'
        }
        It 'Should convert a range to words' {
            $output = 120..122 | ConvertTo-OrdinalWords
            $output[0] | Should Be 'hundred and twentieth'
            $output[1] | Should Be 'hundred and twenty-first'
            $output[2] | Should Be 'hundred and twenty-second'
        }
    }
}

Describe 'Type Extension Methods' {
    Context 'Strings' {
        It 'Should convert to Title Case' {
            'then add nodes under it.'.ToTitleCase | Should Be 'Then Add Nodes Under It.'
        }
        It 'Should convert from Title Case' {
            'FromTitleCase'.Underscore | Should Be 'from_title_case'
        }
        It 'Should truncate words' {
            'then add nodes under it.'.TruncateWords(3) | Should be 'then add nodes…'
        }
        It 'Should truncate characters' {
            'then add nodes under it.'.TruncateCharacters(3) | Should Be 'th…'
        }
        It 'Should truncate with optional character' {
            'then add nodes under it.'.TruncateCharacters(7, '-') | Should Be 'then a-'
        }
        It 'Should Dehumanize' {
            'then add nodes under it.'.Dehumanize | Should Be 'ThenAddNodesUnderIt.'
        }
        It 'Should provide quanity: # word' {
            'string'.ToQuantity(50) | Should Be '50 strings'
        }
        It 'Should provide quantity: words' {
            'string'.ToQuantity(50, "word") | Should Be 'fifty strings'
        }
    }
}

Describe 'Custom Formats' {

}

Remove-Module PowerShellHumanizer