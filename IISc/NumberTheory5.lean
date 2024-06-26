--import Mathlib.Tactic.Basic
--import Mathlib.Tactic.Congr!
--import Mathlib.Data.ZMod.Basic
--import Mathlib.Tactic.Ring
import Mathlib

/-

# Prove that 19 ∣ 2^(2^(6k+2)) + 3 for k = 0,1,2,... 


This is the fifth question in Sierpinski's book "250 elementary problems
in number theory".

thoughts

if a(k)=2^(2^(6k+2))
then a(k+1)=2^(2^6*2^(6k+2))=a(k)^64

Note that 16^64 is 16 mod 19 according to a brute force calculation
and so all of the a(k) are 16 mod 19 and we're done

-/

lemma sixteen_pow_sixtyfour_mod_nineteen : (16 : ZMod 19)^64 = 16 := by
  rfl

example (k : ℕ) : 19 ∣ 2^(2^(6*k+2))+3 := by
  -- sorry
  induction' k with d hd
  { rfl }
  have h : 2 ^ 2 ^ (6 * d.succ + 2) = (2 ^ 2 ^ (6 * d + 2)) ^ 64 := by 
  { rw [← pow_mul]
    apply congrArg
    change _ = _ * 2 ^ 6
    rw [← pow_add]
    rfl
  }
  rw [← ZMod.nat_cast_zmod_eq_zero_iff_dvd, Nat.cast_add, add_eq_zero_iff_eq_neg] at hd ⊢
  rw [h]
  rw [Nat.cast_pow]
  rw [hd]
  convert sixteen_pow_sixtyfour_mod_nineteen
