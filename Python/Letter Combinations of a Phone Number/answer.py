class Solution(object):
    def letterCombinations(self, digits):
        """
        :type digits: str
        :rtype: List[str]
        """
        # return empty list if digits are empty
        len_d = len(digits)
        
        if len_d == 0:
            return ""
        
        # create num_letter_dic
        num_letter_dic, letter_list = {}, []
        num, count = 2, 0
        
        for i in range(97, 123):
            letter_list.append(chr(i))
            count += 1
            if (num in (2,3,4,5,6,8) and count == 3) \
                or (num in (7,9) and count == 4):
                num_letter_dic[num] = letter_list
                num += 1
                letter_list, count = [], 0
        
        # return single list if the length of digits is 1
        if len_d == 1:
            return num_letter_dic[int(digits)]
        
        # convert digits to the list of letter_list
        listof_letter_list = []
        for d in digits:
            listof_letter_list.append(num_letter_dic[int(d)])
        
        # return all the combinations using direct product
        return ["".join(combi) for combi in itertools.product(*listof_letter_list)]
