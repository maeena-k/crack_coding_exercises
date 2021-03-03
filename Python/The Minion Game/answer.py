def minion_game(string):
    str_len = len(string)
    vowels_dic = {}
    for vowl in 'AEIOU':
        vowels_dic[vowl] = ''
    score_s, score_k = 0,0
    
    for i in range(str_len):
        if string[i] not in vowels_dic:
            score_s += str_len - i
        else:
            score_k += str_len - i
    
    if score_s > score_k:
        winner_name_score = '{} {}'.format('Stuart', str(score_s))
    elif score_s < score_k:
        winner_name_score = '{} {}'.format('Kevin', str(score_k))
    elif score_s == score_k:
        winner_name_score = 'Draw'
    
    print(return_val)
            

if __name__ == '__main__':
    s = input()
    minion_game(s)
