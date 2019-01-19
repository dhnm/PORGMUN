//
//  InfoTableViewController
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 13.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit

class CommitteesTableViewController: UITableViewController {
    
    @IBOutlet var infoTableView: UITableView!
    
    let committeesArray = [
        Committee(title: "Historical Security Council",
                  abbreviation: "HSC",
                  description: "The Historical Security Council revisits some of the crises the Security Council has discussed throughout the ages. The committee functions exactly as the Security Council with five permanent, veto-wielding members: the United Kingdom of Great Britain and Northern Ireland, the USA, France, the USSR or Russian Federation and the People´s Republic of China or Republic of China and 6 members elected by the General Assembly (increased to 10 members in 1965). The delegates have a chance to bring their perspective into some of the most divisive issues and solve them with the aid of hindsight.",
                  topics: [
                    (name: "The case of Adolf Eichman and its implications for the post-war world order",
                     description: "In May 1960, one of the most wanted Nazi figureheads of the Holocaust, SS-Obersturmbannführer Adolf Eichmann, was captured and forcibly relocated from Argentina to Israel by Mossad, an Israeli intelligence agency. Israel did not properly inform Argentina of the operation, nor did it have the permission to conduct such actions, which the Argentine Republic interpreted as a breach of its national sovereignty. Israel claimed that it had no involvement in the abduction of Adolf Eichmann.. Israel further argued that once Eichmann had reached Israel it was simply an obligation for the locals to arrest the war criminal and put him on trial. Argentine negotiations with the Israeli side failed to reach a satisfying conclusion, which is why the Argentine Republic appealed to the UN Security Council to resolve this issue. Israel was invited to the negotiating table as a non-voting party.",
                     file: "hsc1.pdf")],
                  countryMatrix: "State of Israel (Spectator), Argentine Republic, United States of America, Union of Soviet Socialist Republics, United Kingdom of Great Britain and Northern Ireland, Republic of China, Italian Republic, People´s Republic of Poland, Republic of Tunisia, Republic of Ecuador, Dominion of Ceylon, French Republic"
        ),
        Committee(title: "Special Political and Decolonisation Committee",
                  abbreviation: "SPECPOL",
                  description: "The United Nations General Assembly’s fourth main standing committee is responsible for the rigorous consideration of draft resolutions surrounding issues broadly involving matters of peace and decolonization.",
                  topics: [
                    (name: "Outlining the Extent of Cooperation Between Government Agencies with Regards to Major Terrorist Activity in Order to Effectivize Global Counter-Terrorism Efforts",
                     description: "In a world of increasing terrorist activity, where terror attacks have already cost countless lives, the international community must band together in order to prevent further damage. This calls for an increased level of intergovernmental cooperation. The aim of this Special Council is to outline a basic agreement by which all parties would be bound to share intelligence and resources that could aid the international community in fighting terrorism on a global scale, as well as to establish a system of sanctions to be put into action were any of the parties to violate such an agreement.",
                     file: "specpol1.pdf"),
                    (name: "Resolving the Humanitarian Crisis in the Republic of the Union of Myanmar",
                     description: "For several years now, violent Buddhist extremists have been accused of conducting categorical ethnic cleansing of the Rohingya Muslim minority, with several thousand casualties to date. In most recent developments, the religious extremists have supposedly gained support from the unofficial Burmese Military Government and as such the situation in the country has become an alarming humanitarian crisis. The aim of this committee is to advise the UNSC on the topic and suggest possible solutions in order to quell the suffering of the Burmese people.",
                     file: "specpol2.pdf")],
                  countryMatrix: "People's Republic of China, Federal Republic of Germany, French Republic, Russian Federation, United Kingdom of Great Britain and Northern Ireland, United States of America, State of Japan, State of Israel, Federative Republic of Brazil, United Arab Emirates, Kingdom of Saudi Arabia, Kingdom of Spain, Canada, South Korea, Republic of Turkey, Republic of India, Republic of the Union of Myanmar, Kingdom of Sweden, Republic of South Africa, Arab Republic of Egypt, Argentine Republic, United Mexican States, Iraq, Kingdom of the Netherlands, People`s Republic of Bangladesh"
        ),
        Committee(title: "Economic and Social Council",
                  abbreviation: "ECOSOC",
                  description: "ECOSOC is one of the six main organs of the UN established by the UN Charter in 1946 and principally deals with coordinating, reviewing and dialogue regarding economic, social and environmental issues and their implementation on an international scale. It also serves as a supervising organ for the subsidiary expert bodies present in the Council.",
                  topics: [
                    (name: "Promoting regionally-sourced food as a means of combatting climate change and creating healthy self-sufficient communities",
                     description: "It is quickly becoming clear that one of the most difficult challenges to overcome in the 21st century is the uphill battle that human-caused climate change has turned out to be. One of the underlying problems that perpetuate the enormous human impact on the environment is the way interconnected societies in today’s globalised world approach the logistical issue of finding or creating food sources for their ever-growing populations. This dilemma between self-sufficiency and high availability of cheap foodstuffs in foreign countries often results in the need to import food in a manner that produces massive amounts of emissions that have a negative effect on the environment. One of the ways to combat this is the development of sustainable, environmentally-friendly food sources that can be maintained on a regional level to prevent the destructive carbon footprint that is associated with the globalisation of food distribution.",
                     file: "ecosoc1.pdf"),
                    (name: "Instituting humane working conditions for migrant workers",
                     description: "The United Nations Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families defines the term “migrant worker” as a person who is engaged or has been engaged in a remunerated activity in a State of which they are not citizens. The Convention itself has only been ratified by 49 states, almost exclusively sources of origin for migrant workers such as Mexico and Bangladesh. Prominent migrant-receiving states in North America, Western Europe, and in the Persian Gulf have not yet ratified the Convention and high-profile instances of the abuse and neglect of migrant workers prevail. Blatant cases of abuse such as the construction of the Qatar World Cup stadium, where workers had their passports confiscated and were forced to work excessive hours for days on end remind us that it is necessary to institutionalise the rights of migrant workers in receiving countries or face the further dehumanisation of migrant labour to a point where humans with rights and freedoms become expendable tools.",
                     file: "ecosoc2.pdf")],
                  countryMatrix: "Argentine Republic, Japan, Kingdom of Thailand, Republic South Africa, Russian Federation, Canada, Kingdom of Denmark, Malaysia, Republic of France, State of Qatar, Commonwealth of Australia, Kingdom of Norway, Kingdom of the Netherlands, Republic of India, United Kingdom of Great Britain and Northern Ireland, Federal Republic of Germany, Kingdom of Saudi Arabia, People’s Republic of Bangladesh, Republic of Indonesia, United Mexican States, Islamic Republic of Pakistan, Kingdom of Sweden, People’s Republic of China, Republic of Turkey, United States of America"
        ),
        Committee(title: "Disarmament and International Security",
                  abbreviation: "DISEC",
                  description: "The “First Committee” deals mainly with the question of disarmament, global threats to peace and challenges to international security. Its goals are promoting stability through regulation, transparency and ultimately decreasing the number of armaments and furthermore the co-operation and maintenance of international peace.",
                  topics: [
                    (name: "Establishing formal mechanisms to prevent the diversion of arms from developed countries to conflict zones in the Middle East and North Africa",
                     description: "Conflicts in the Middle East and North Africa continue to be fuelled by the import of foreign arms from Europe and North America, which often end up on opposing sides of the struggle sooner rather than later. With the civil war in Libya and on a larger scale the Syrian conflict being supplied by freshly minted armaments made in Eastern Europe, it is paramount that even with the ATT (Arms Trade Treaty) in place, practical means to curb the illicit transfer of weapons to organisations that could possibly violate human rights and threaten regional stability are put in place. Furthermore, it is necessary that if arms indeed do find themselves in high-risk combat zones, they need to be accounted for in every possible way in order to prevent proliferation among extremist groups in the Middle East and North Africa.",
                     file: "disec1.pdf"),
                    (name: "Tackling the question of usage of autonomous weapon systems in military conflicts",
                     description: "Slowly but steadily, the innovation achieved in the fields of artificial intelligence and deep learning are steering the development of the world’s militaries towards the seemingly practical choice of autonomous weaponry, which operates independently and does not require human supervision. This, however, carries significant ethical implications which have already been noticed by leaders in the AI industry. An open letter to the United Nations, signed by field experts behind Tesla and Google DeepMind, is calling on the international community to issue a ban on lethal autonomous weapons, which are already in operation in a limited scope on the border between South and North Korea. While the introduction of combat drones raised protests regarding the loss of civilian life, autonomous weapons remove the human factor completely and are able to independently make the decision to employ lethal force. While one side argues that autonomous weapons would significantly reduce the loss of human life in combat situations, it should be noted that the loss of human life is the only thing preventing warfare from reaching gargantuan and potentially catastrophic parameters and that autonomous weapons could be deployed against civilian populations with devastating efficiency. This is an extremely multifaceted problem and the international community will have to make a decision on the matter before it becomes necessary.",
                     file: "disec2.pdf")],
                  countryMatrix: "Arab Republic of Egypt, Kingdom of Morocco, People’s Republic of China, Republic of Serbia, Syrian Arab Republic, Czech Republic, Kingdom of Saudi Arabia, Republic of Estonia, Republic of Turkey, Ukraine, Federal Republic of Germany, Libya, Republic of France, Republic of the Sudan, United Arab Emirates, Hashemite Kingdom of Jordan, The Kingdom of the Netherlands, Republic of Iraq, Russian Federation, United Kingdom of Great Britain and Northern Ireland, Italian Republic, People's Democratic Republic of Algeria, Republic of Korea, State of Israel, United States of America"
        ),
        Committee(title: "Security Council",
                  abbreviation: "SC",
                  description: "The Security Council is the primary organ of the UN responsible for maintaining peace and security on an international scale. Member states are obligated to comply with the Council decisions under the charter. The SC will be at the forefront of decision-making when it comes to acts of aggression and in some cases can impose sanctions and authorise the use of force when a threat to international security emerges. It has 15 members, 5 of which are permanent, with the rest rotating every 2 years. Lastly and perhaps most importantly, the Permanent 5 wields veto powers, enabling them to prevent the adoption of any substantive resolution.",
                  topics: [
                    (name: "De-escalating the conflict on the Korean peninsula",
                     description: "The deep division of the Korean Peninsula ranges back to the post-World War II Soviet and American occupation and the resultant radical differences in ideology adopted by the governments on opposing sides of the 38th parallel. A Stalinist regime led by Kim Il-sung with the support of the USSR and China faced off with the American-backed administration of Syngman Rhee as both countries expressed their desire for forceful reunification under their respective ideologies. After considerable military escalation resulting in two major conflicts over a 20-year period, an uneasy status quo was reached between the two Koreas with the use of a demilitarised zone dividing them. Tensions between the two countries haven’t subsided in the slightest and lately even further escalated with incidents including the sinking of a South Korean warship and joint military exercises conducted between the United States and South Korea. Currently, the conflict is reaching new heights as the DPRK is actively working on its nuclear armament programme and more sanctions are imposed on the North Korean economy by the international community. The Security Council will have to set aside its differences and quarrels in other aspects of global politics and channel its focus on a peaceful resolution of the conflict for the greater good of the region.",
                     file: nil)],
                  countryMatrix: "Democratic People’s Republic of Korea, Japan, Republic of France, Republic of Zimbabwe, Syrian Arab Republic, Democratic Republic of the Congo, People’s Republic of China, Republic of India, Republic of the Philippines, United Kingdom of Great Britain and Northern Ireland, Islamic Republic of Iran, Republic of Bulgaria, Republic of Korea, Russian Federation, United States of America"
        ),
        Committee(title: "Legal Committee",
                  abbreviation: "LEGAL",
                  description: "As the primary forum for the consideration of legal questions in the General Assembly, the Legal Committee, the sixth committee of the UNGA, oversees reviewing procedural questions submitted to it by the conference, reviewing conventions, as well as providing legal recommendations and assessments. It is a quintessential part of the United Nations framework of bodies and agencies.",
                  topics: [
                    (name: "Defining the necessary conditions for preemptive use of military force under international law, especially in context of terrorism and other militant groups",
                     description: "Traditional international law requires there to be “an imminent danger of attack” before preemption is permissible. As such, it has come under question what constitutes such “an imminent danger of attack” that would validate preemptive military steps. To assure that warfare is properly mandated and thus fits into the “just war” doctrine, it is imperative that the international community comprehensively addresses this question, accurately defines what preemptive warfare is, to what extent it can be allowed, the conditions that need to be met, and how this will be effectively overseen.",
                     file: "legal1.pdf"),
                    (name: "Reassessing the Geneva conventions in light of contemporary asymmetric warfare",
                     description: "The Geneva conventions, negotiated over 50 years ago, have increasingly come under critique as for their predisposition to hinder the fight of legitimate government forces and groups against non-state actors, thereby endangering the civilian populace it primarily aimed to protect. In an era of warfare transcendent of tradition, when allies, enemies, and civilians can no longer be distinguished by merely attire, when the structure of violent militant groups is chaotic and disorganized, and when war is no longer just a means to settle a dispute, the Geneva conventions are becoming increasingly more difficult and arguably irrational to uphold. To what extent and how can we change this fundamental source of International Humanitarian Law as not to hinder our ability to compete with modern threats whilst respecting basic human rights?",
                     file: "legal2.pdf")],
                  countryMatrix: "United States of America, Russian Federation, People’s Republic of China, French Republic, United Kingdom of Great Britain and Northern Ireland, Syrian Arab Republic, Islamic Republic of Afghanistan, Kingdom of Saudi Arabia, Republic of Iraq, Republic of the Union of Myanmar, State of Israel, Republic of Yemen, Canada, Federal Republic of Germany, Kingdom of Denmark, Democratic People’s Republic of Korea, Republic of Korea, Czech Republic, Kingdom of Spain, Kingdom of Belgium, Republic of Cyprus, Republic of Turkey, Hellenic Republic, Ukraine, Republic of Finland"
        ),
        Committee(title: "International Monetary Fund",
                  abbreviation: "IMF",
                  description: "The International Monetary Fund, also known as The IMF or the Fund, was established at the Bretton Woods UN conference in July 1944. Its primary purpose is to ensure the stability of the international monetary system, however, in 2012 the Fund's mandate was updated to include all macroeconomic and financial sector issues that bear on global stability.",
                  topics: [
                    (name: "A Strive for Sructural Reform: Ensuring Transparency, Accountability, Democracy, and Equality Within the IMF",
                     description: "Scholars and policy-makers alike both recognize the many flaws and issues with the current conduct of the IMF. It is perceived as undemocratic with the vast majority of “borrowers” being minority stakeholders while a relatively small group of industrial states holds 60 percent of the voting power. The selection process of its Managing Director has been criticized for lacking transparency and being procedurally unclear. The dominance of developed countries has no effective counter-weight even in its executive and oversight boards and it’s means of conduct tend to disregard for the interests of those in most need. The IMF is in dire need of an internal review and more importantly, reform to assure it will not be rendered obsolete in the future and will continue to fulfil its role within the international community.",
                     file: "imf1.pdf"),
                    (name: "Privatization of Public Assets in Developing States",
                     description: "Privatization has grown to become a very popular tool of economic policy in both developing and developed states. It is the process of transferring activities carried out by the government, any of its agencies, or any other state-owned enterprises to be performed by private undertakings. While the process, as a concept, may seem simple, its implementation has proven to be extremely difficult and recognized as potentially dangerous to developing states, particularly due to the larger proportion of assets privatized by international persons rather than locals. Take the example of East Timor, whose oil and natural gas reserves were estimated to be worth US $ 40 billion over 17 years and East Timor stood to gain only US $ 3.2 billion, about 8 per cent. As such, it is imperative to decide whether privatization, though in theory beneficial for the economy and local industry, is in the interest of developing states and if it is, how it should be carried out to maximize protection of developing states.",
                     file: "imf2.pdf")],
                  countryMatrix: "United States of America, United Kingdom of Great Britain and Northern Ireland, French Republic, State of Japan, Federal Republic of Germany, Italian Republic, Republic of Ghana, Republic of Haiti, Republic of Korea, People’s Republic of China, Republic of Latvia, Islamic Republic of Pakistan, Russian Federation, Kingdom of Saudi Arabia, The Kingdom of the Netherlands, Kingdom of Sweden, Republic of Burundi, Democratic Republic of the Congo, Republic of Mali, United Mexican States"
        ),
        Committee(title: "Arab League",
                  abbreviation: "AL",
                  description: "The Arab League is a regional organisation of twenty-two Arab nations, founded in 1945 with the intention to “draw closer the relations between member states and co-ordinate collaboration between them, to safeguard their independence and sovereignty, and to consider in a general way the affairs and interests of the Arab countries”. The League has set out to help the Arab world grow economically and culturally, while finding solutions to conflicts both within the league and outside of it through mediation.",
                  topics: [
                    (name: "The War in Yemen",
                     description: "Yemen is in the midst of a humanitarian crisis after two years of war between forces loyal to the internationally-recognised government of President Abdrabbuh Mansour Hadi, backed by the Saudi-led coalition, and those allied to the Houthi rebel movement. UN - mediated talks have failed to reach a solution, Yemeni citizens are victims of human rights violations by all parties to the conflict and the involvement of Iran and the Gulf states pose a threat of drawing the country into the broader conflict of the Sunni-Shia divide. Meanwhile, Al-Qaeda in the Arabian Peninsula has seized their opportunity by claiming areas in the south and the self-declared Islamic state targeting the Houthi headquarters. Although the involvement of the international community has been substantial, it is largely up to the Arab states to act in accordance to the League’s charter and bring a halt to this dispute.",
                     file: "al1.pdf"),
                    (name: "Revisiting the Arab Peace Initiative",
                     description: "The Arab Peace initiative was first introduced by Saudi Arabia at the 2002 Arab League summit as a 10-sentence proposal to normalise the relationship between the Arab world and Israel. In return, Saudi Arabia demanded the full withdrawal of Israel from occupied territories. Israeli leaders promptly disagreed. The Arab League has since endeavoured to alter the Arab Peace initiative in its efforts to resolve the Israeli-Palestine conflict and secure the sovereignty of the Palestinian state, reintroducing it at the 2007 and 2017 summit. Yet, the negotiation process between Israel and the Arab world remains at a deadlock. The Arab League must come together and unanimously agree on the details of Palestinian status and draft a unifying course of action if the conflict with Israel is to ever be resolved.",
                     file: "al2.pdf")],
                  countryMatrix: "People’s Democratic Republic of Algeria, Kingdom of Bahrain, Union of the Comoros, Republic of Djibouti,Arab Republic of Egypt,Islamic Republic of Iran,Republic of Iraq, Hashemite Kingdom of Jordan,State Kuwait, Lebanese Republic, Libya, Islamic Republic of Mauritania, Kingdom of Morocco, Sultanate of Oman, State of Palestine, State of Qatar, Kingdom of Saudi Arabia, Federal Republic of Somalia, Republic of the Sudan, Tunisian Republic, United Arab Emirates, Republic of Yemen"
        ),
        Committee(title: "African Union",
                  abbreviation: "AU",
                  description: "The African Union is a continental union consisting of all 55 states on the African continent. With its fourteen defined objectives the African Union strives towards a “peaceful, prosperous and integrated Africa driven by its own citizens and representing a dynamic force in the global arena.” The African Union is made up of both political and administrative bodies, with the highest decision-making organ - the Assembly being made up of all the heads of state.",
                  topics: [
                    (name: "Child Marriage: The Conflict of Human Rights and Cultural Tradition",
                     description: "Child marriage is an alarmingly common human rights violation on the African continent. Newest reports conclude that approximately 40% of girls in Sub-Saharan Africa are married before they reach the age of 18. With the young brides being deprived of their rights to education, health and safety, child marriage perpetuates the cycle of poverty and hinders the advancement of developing countries. Child marriage is an issue where the resolution lies beyond the eradication of poverty, as the practice is often engrained in the cultural traditions followed for centuries. Even if laws condemning the practice are passed, cultural values take priority in many cases, warranting a more thorough solution of the complex issue at hand.",
                     file: "au1.pdf"),
                    (name: "The Conflict in the DRC: Facing the Risks Posed by the Presence of Foreign Militant Groups",
                     description: "The DRC has faced a surge of militant groups ever since the influx of refugees fleeing the Rwandan genocide in 1994, bringing considerable ethnic tensions with them. Despite the signing of a peace deal following the Second Congo War, the weak Congolese governance, corruption and lawlessness in the country has allowed for ongoing violence. There are currently at least seventy armed groups operating in the eastern DRC and the situation does not seem to be improving even with 19,000 UN peacekeepers present in the area. Militant groups, the Rwandan FDLR and Ugandan ADF in particular, exploit the country’s rich natural resources to fund their operations, putting Congolese miners out of work. Millions have been forced to flee the country due to extensive human rights violations, violence and poverty - the latest UN estimates are 2.7 million internally displaced persons and 450 thousand refugees residing in bordering countries.",
                     file: "au2.pdf")],
                  countryMatrix: "People’s Democratic Republic of Algeria, Republic of Angola, Republic of Botswana, Republic of Burundi, Republic of Chad, Central African Republic, Republic of the Congo, Democratic Republic of the Congo, Arab Republic of Egypt, Federal Democratic Republic of Ethiopia, Republic of Mali, Kingdom of Morocco, Republic of Namibia, Republic of the Niger, Federal Republic of Nigeria, Republic of Rwanda, Republic of South Africa, Republic of South Sudan, Republic of Uganda, Republic of Zimbabwe"
        ),
        Committee(title: "Human Rights Council",
                  abbreviation: "HRC",
                  description: "The United Nations Human Rights Council is an international body which seeks to ensure the upholding of Human Rights around the globe. Established in 2006, the HRC is a forum tasked with promoting and protecting human rights. In recent years, its primary focus has been examining concrete human rights abuses around the world and coming up with cohesive solutions to these problems.",
                  topics: [
                    (name: "Ensuring Protection of the Rights of LGBTQIA+ Individuals and Devising Measures By Which to Minimise Sexuality-Based Discrimination",
                     description: "Even though the international community has been making great progress regarding LGBTQIA+ rights in recent years, there are still parts of the world where citizens can be discriminated against, persecuted, or even killed because of their sexuality. To cite the UNHRC 2016 Age, Gender and Diversity Accountability Report, “One operation in Europe noted that LGBTI persons reported insecurity and isolation resulting from fear of the risk of sexual abuse. Two other operations, one in Africa and another in the MENA region, reported LGBTI refugees and asylum-seekers in urban areas were forced to engage in sex work, that often exposed them to SGBV risks, as they were unable to get jobs because of factors such as discrimination and a lack of official documentation.”. Considering that the principal mission of the Human Rights Council is to ensure and protect human rights, it is also its mission to protect citizens of the world from being discriminated against because of their sexuality.",
                     file: "hrc1.pdf"),
                    (name: "Ensuring the Implementation and Enforcement of Measures that Would Lead to Eliminating the Practice of Female Circumcision and Other Forms of Female Genital Mutilation",
                     description: "Albeit outlawed in most parts of the world, the barbaric practice of female circumcision and/or Female Genital Mutilation (FGM) remain alarmingly common to this day. For example, over 91% percent of women and girls aged 15-49 have undergone the procedure in modern-day Egypt, a WHO report concludes. The same report estimates that over 200 million women in the world have fallen victims to this practice and 3 million are at risk of having to undergo it every year. Moreover, growing migration has increased the number of girls and women living outside their country of origin who have undergone female genital mutilation or who may be at risk of being subjected to the practice in Europe, Australia and North America.",
                     file: "hrc2.pdf")],
                  countryMatrix: "United States of America, Russian Federation, People’s Republic of China, United Kingdom of Great Britain and Northern Ireland, French Republic, Federal Republic of Germany, Kingdom of Saudi Arabia, Islamic Republic of Iran, Republic of Sudan, Republic of Benin, Canada, Republic of the Niger, Commonwealth of Australia, Syrian Arab Republic, Republic of India, Democratic People’s Republic of Korea, Czech Republic, Republic of Cyprus, Arab Republic of Egypt, Republic of Guinea, Federal Democratic Republic of Ethiopia, Republic of Mali, Kingdom of Spain, Kingdom of Sweden, Republic of Finland, Republic of Belarus, Slovak Republic, Republic of Poland, Kingdom of Thailand, Federative Republic of Brazil, Bolivarian Republic of Venezuela, Republic of Indonesia, Kingdom of Belgium, The Kingdom of the Netherlands, Republic of Trinidad and Tobago"
        ),
        Committee(title: "International Court of Justice",
                  abbreviation: "ICJ",
                  description: "The International Court of Justice, generally refered to as the ICJ is the primary judicial branch of the United Nations. Its role is to settle legal disputes that cannot be resolved at the national level, as well as to provide advisory opinions on legal matters submitted to it by UN organisations for consideration based upon various sources of international law. Its decisions are then enforced by the Security Council and set precedents for future practice.",
                  topics: [(name: "The case debated will be announced.",
                           description: "",
                           file: nil)],
                  countryMatrix: ""
        )
        
    ]
    
    
    internal override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
    }
    
    internal override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return ""
        
    }
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 && false {
            
            return 1
            
        }
        
        return committeesArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            
        return 44
        
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && false {
            
            let cell = infoTableView.dequeueReusableCell(withIdentifier: "preambleCell", for: indexPath)
            
            cell.imageView?.image = #imageLiteral(resourceName: "fa-book@3x.png")
            cell.textLabel?.text = "Rules & Procedure"
            
            return cell
            
        } else {
        
            let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
            cell.textLabel?.text = committeesArray[indexPath.row].title
            cell.detailTextLabel?.text = committeesArray[indexPath.row].abbreviation
        
            cell.imageView?.image = UIImage(named: committeesArray[indexPath.row].abbreviation.lowercased() + ".jpg")
            
            return cell
            
        }
        
    }
    
    /* internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let coords = dictionaryHandling(indexPath: indexPath)["coords"] as! CLLocationCoordinate2D
     
     let initialLocation = CLLocation(latitude: coords.latitude, longitude: coords.longitude)
     
     centerMapOnLocation(location: initialLocation, radius: 500)
     
     print("5")
     
     } */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = #imageLiteral(resourceName: "logo-black@2x.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Table view data source
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
         if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         RecipeDetailViewController *destViewController = segue.destinationViewController;
         destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
         }
         */
        
        if segue.identifier == "committeeDetailSegue" {
            
            if let destinationVC = segue.destination as? CommitteesDetailTableViewController {
                
                let indexPath: IndexPath = self.infoTableView.indexPathForSelectedRow!
                
                destinationVC.data = committeesArray[indexPath.row]
                
            }
            
        }
        
    }
    
    
}

struct Committee {
    
    let title: String
    let abbreviation: String
    let description: String
    let topics: [(name: String, description: String, file: String?)]
    let countryMatrix: String
    
    init(title: String, abbreviation: String, description: String, topics: [(name: String, description: String, file: String?)], countryMatrix: String) {
        
        self.title = title
        self.abbreviation = abbreviation
        self.description = description
        self.topics = topics
        self.countryMatrix = countryMatrix
        
    }
    
}
