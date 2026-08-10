-- =========================================================
-- Table des 69 wilayas d'Algérie (Loi 26-06, novembre 2025)
-- =========================================================

CREATE TABLE IF NOT EXISTS public.wilayas (
  code VARCHAR(2) PRIMARY KEY,
  name_fr VARCHAR(100) NOT NULL,
  name_en VARCHAR(100) NOT NULL,
  name_ar VARCHAR(100) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.wilayas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "wilayas_public_read" ON public.wilayas;
CREATE POLICY "wilayas_public_read" ON public.wilayas
  FOR SELECT USING (true);

INSERT INTO public.wilayas (code, name_fr, name_en, name_ar) VALUES
('01', 'Adrar', 'Adrar', 'أدرار'),
('02', 'Chlef', 'Chlef', 'الشلف'),
('03', 'Laghouat', 'Laghouat', 'الأغواط'),
('04', 'Oum El Bouaghi', 'Oum El Bouaghi', 'أم البواقي'),
('05', 'Batna', 'Batna', 'باتنة'),
('06', 'Béjaïa', 'Bejaia', 'بجاية'),
('07', 'Biskra', 'Biskra', 'بسكرة'),
('08', 'Béchar', 'Bechar', 'بشار'),
('09', 'Blida', 'Blida', 'البليدة'),
('10', 'Bouira', 'Bouira', 'البويرة'),
('11', 'Tamanrasset', 'Tamanrasset', 'تمنراست'),
('12', 'Tébessa', 'Tebessa', 'تبسة'),
('13', 'Tlemcen', 'Tlemcen', 'تلمسان'),
('14', 'Tiaret', 'Tiaret', 'تيارت'),
('15', 'Tizi Ouzou', 'Tizi Ouzou', 'تيزي وزو'),
('16', 'Alger', 'Algiers', 'الجزائر'),
('17', 'Djelfa', 'Djelfa', 'الجلفة'),
('18', 'Jijel', 'Jijel', 'جيجل'),
('19', 'Sétif', 'Setif', 'سطيف'),
('20', 'Saïda', 'Saida', 'سعيدة'),
('21', 'Skikda', 'Skikda', 'سكيكدة'),
('22', 'Sidi Bel Abbès', 'Sidi Bel Abbes', 'سيدي بلعباس'),
('23', 'Annaba', 'Annaba', 'عنابة'),
('24', 'Guelma', 'Guelma', 'قالمة'),
('25', 'Constantine', 'Constantine', 'قسنطينة'),
('26', 'Médéa', 'Medea', 'المدية'),
('27', 'Mostaganem', 'Mostaganem', 'مستغانم'),
('28', 'M''Sila', 'M''Sila', 'المسيلة'),
('29', 'Mascara', 'Mascara', 'معسكر'),
('30', 'Ouargla', 'Ouargla', 'ورقلة'),
('31', 'Oran', 'Oran', 'وهران'),
('32', 'El Bayadh', 'El Bayadh', 'البيض'),
('33', 'Illizi', 'Illizi', 'إليزي'),
('34', 'Bordj Bou Arréridj', 'Bordj Bou Arreridj', 'برج بوعريريج'),
('35', 'Boumerdès', 'Boumerdes', 'بومرداس'),
('36', 'El Tarf', 'El Tarf', 'الطارف'),
('37', 'Tindouf', 'Tindouf', 'تندوف'),
('38', 'Tissemsilt', 'Tissemsilt', 'تيسمسيلت'),
('39', 'El Oued', 'El Oued', 'الوادي'),
('40', 'Khenchela', 'Khenchela', 'خنشلة'),
('41', 'Souk Ahras', 'Souk Ahras', 'سوق أهراس'),
('42', 'Tipaza', 'Tipaza', 'تيبازة'),
('43', 'Mila', 'Mila', 'ميلة'),
('44', 'Aïn Defla', 'Ain Defla', 'عين الدفلى'),
('45', 'Naâma', 'Naama', 'النعامة'),
('46', 'Aïn Témouchent', 'Ain Temouchent', 'عين تموشنت'),
('47', 'Ghardaïa', 'Ghardaia', 'غرداية'),
('48', 'Relizane', 'Relizane', 'غليزان'),
('49', 'Timimoun', 'Timimoun', 'تيميمون'),
('50', 'Bordj Badji Mokhtar', 'Bordj Badji Mokhtar', 'برج باجي مختار'),
('51', 'Ouled Djellal', 'Ouled Djellal', 'أولاد جلال'),
('52', 'Béni Abbès', 'Beni Abbes', 'بني عباس'),
('53', 'In Salah', 'In Salah', 'عين صالح'),
('54', 'In Guezzam', 'In Guezzam', 'عين قزام'),
('55', 'Touggourt', 'Touggourt', 'تقرت'),
('56', 'Djanet', 'Djanet', 'جانت'),
('57', 'El M''Ghair', 'El M''Ghair', 'المغير'),
('58', 'El Meniaa', 'El Meniaa', 'المنيعة'),
('59', 'Aflou', 'Aflou', 'أفلو'),
('60', 'Barika', 'Barika', 'بريكة'),
('61', 'El Kantara', 'El Kantara', 'القنطرة'),
('62', 'Bir El Ater', 'Bir El Ater', 'بئر العاتر'),
('63', 'El Aricha', 'El Aricha', 'العريشة'),
('64', 'Bou Saâda', 'Bou Saada', 'بوسعادة'),
('65', 'Ksar El Boukhari', 'Ksar El Boukhari', 'قصر البخاري'),
('66', 'Ksar Chellala', 'Ksar Chellala', 'قصر الشلالة'),
('67', 'Messaad', 'Messaad', 'مسعد'),
('68', 'Aïn Oussera', 'Ain Oussera', 'عين وسارة'),
('69', 'El Abiodh Sidi Cheikh', 'El Abiodh Sidi Cheikh', 'الأبيض سيدي الشيخ')
ON CONFLICT (code) DO UPDATE SET
  name_fr = EXCLUDED.name_fr,
  name_en = EXCLUDED.name_en,
  name_ar = EXCLUDED.name_ar;
